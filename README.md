# mulukhiya-rubicure

プリキュア淑女録スプレッドシートにアクセスするためのAPIを提供するCLIツールです。
[モロヘイヤ](https://github.com/pooza/mulukhiya-toot-proxy/)のプラグインとしても利用できます。

## 使い方

```bash
bin/cure.rb girls              # すべてのプリキュア (JSON)
bin/cure.rb girls index        # すべてのプリキュアの名前 (JSON)
bin/cure.rb girls black        # 指定したプリキュア (JSON)
bin/cure.rb girls calendar     # プリキュアの誕生日カレンダー (iCalendar)
bin/cure.rb series             # すべてのシリーズ (JSON)
bin/cure.rb series index       # すべてのシリーズの名前 (JSON)
bin/cure.rb series unmarked    # 指定したシリーズ (JSON)
bin/cure.rb cast calendar      # キャストの誕生日カレンダー (iCalendar)
bin/cure.rb livecure           # 直近の実況日程 (JSON)
bin/cure.rb livecure calendar  # 直近の実況日程 (iCalendar)
bin/cure.rb help               # ヘルプ
```

## テスト

```bash
bin/test.rb
```

## データソース

プリキュアのデータは Google Spreadsheet をソースとし、GAS (Google Apps Script) 経由でJSON APIとして提供しています。

- [girls用スプレッドシート](https://docs.google.com/spreadsheets/d/1Tba5B-l2zwLkYs-SRhI_whKHNY86CYmlIp_Xu6WPILk/edit)
- [series用スプレッドシート](https://docs.google.com/spreadsheets/d/1BLJXOFMqayF75-sVLJY56XwnNhmyck_RGRLWKm3wXB4/edit)

## GASデプロイ

### 前提

```bash
npm install -g @google/clasp
clasp login
```

### pushとデプロイ

```bash
cd gas/girls
clasp push
```

```bash
cd gas/series
clasp push
```

`clasp push` でGASプロジェクトにコードが反映されます。
初回または新バージョンを公開する場合は、GASエディタからウェブアプリとしてデプロイしてください。
