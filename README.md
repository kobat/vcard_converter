# vcard_converter
vCardファイルをTSVに変換する。携帯からAndroidへの移行時に連絡先を移すのに困ったので書いた即席スクリプト。
この結果を適当にExcelなどで加工して、Googleコンタクトにインポートした。

- 入出力は標準入力/標準出力。UTF-8前提
- 項目を漏れなく横に並べる
- 一部の項目は別項目を作成
  - 氏名を姓と名に分ける（スペースなどで見分けが付く場合）
  - 読み仮名の半角カナを全角カナに変換
  - 読み仮名を姓と名に分ける（スペースなどで見分けが付く場合）
