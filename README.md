# mulukhiya-rubicure

[モロヘイヤ](https://github.com/pooza/mulukhiya-toot-proxy/)からプリキュア関連の情報を返せる様にするプラグインです。
詳しい使い方は、リポジトリのディレクトリで `bin/cure.rb help` を実行。

設定例は、[こちら](https://github.com/pooza/mulukhiya-toot-proxy/wiki/%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%A0API)を参照。

## GASデプロイ

プリキュアのデータは [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1Tba5B-l2zwLkYs-SRhI_whKHNY86CYmlIp_Xu6WPILk/edit) をソースとし、GAS (Google Apps Script) 経由でJSON APIとして提供しています。

### 前提

```bash
npm install -g @google/clasp
clasp login
```

### pushとデプロイ

```bash
cd gas
clasp push
```

`clasp push` でGASプロジェクトにコードが反映されます。
初回または新バージョンを公開する場合は、GASエディタからウェブアプリとしてデプロイしてください。
