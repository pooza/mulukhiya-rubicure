# rubicure gem脱却の設計メモ

## 経緯

rubicureライブラリはRubyの実装としての正しさを追求しているが、肝心のデータに間違いがあり方向性の違いを感じたため、自前のデータソースに切り替えることにした。

## データソース

- [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1Tba5B-l2zwLkYs-SRhI_whKHNY86CYmlIp_Xu6WPILk/edit) をマスターデータとする
- GAS (Google Apps Script) でJSON APIとして公開
- GASのコードは `gas/` ディレクトリで管理し、`clasp push` でデプロイ

## スプレッドシート構成

### girlsシート

| カラム | 内容 |
|---|---|
| `key` | 識別キー (例: `cure_sword`) |
| `cure_name` | プリキュア名 (例: キュアソード) |
| `human_name` | 人間名 (例: 剣崎 真琴) |
| `cv` | 声優 |
| `nickname` | ニックネーム (カンマ区切り) |
| `nickname_unofficial` | 非公式ニックネーム (カンマ区切り) |
| `birthday` | 誕生日 (m/d形式) |
| `cv_birthday` | 声優誕生日 (m/d形式) |
| `title` | シリーズ名 |

### seriesシート

| カラム | 内容 |
|---|---|
| `key` | 識別キー (例: `dokidoki`) |
| `title` | シリーズ名 (例: ドキドキ！プリキュア) |

## GAS APIエンドポイント

- `?action=girls` — 全プリキュアの詳細データ (JSON配列)
- `?action=series` — 全シリーズデータ (JSON配列、girlsシートからメンバーを自動収集)
- パラメータなし — 名前の関連付けマップ (既存互換)

## Ruby側の構成

- `Datasource` — GAS APIからデータを取得しキャッシュするシングルトン
- `Girl` — 各プリキュアのデータラッパー。rubicureの`Girl`互換メソッドを提供
- 各Tool/Calendarクラスは `Datasource.instance` 経由でデータにアクセス

## rubicureからの主な変更点

- `Precure.all` → `Datasource.instance.girls`
- `::Rubicure::Girl.find(sym)` → `Datasource.instance.find_girl(name)`
- `::Rubicure::Series.find(sym)` → `Datasource.instance.find_series(name)`
- `transform_message` は廃止 (スプレッドシートに該当データなし)
- `short_cure_name` は使用しない (`key`列で識別)

## 設定

`config/application.yaml` に `gas.url` を追加:

```yaml
gas:
  url: https://script.google.com/macros/s/DEPLOYMENT_ID/exec
```
