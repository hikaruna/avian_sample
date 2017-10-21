このサンプルは、 https://github.com/ReadyTalk/avian#embedding を実際にやってみたものです。

(avian)[https://github.com/ReadyTalk/avian]
Copyright (c) 2008-2015, Avian Contributors

## 使い方

```
$ git clone --recurse-submodules <this_repository>
$ make
$ open hello
```

## make タスク
  - default: buildと同じ
  - build: https://github.com/ReadyTalk/avian#embedding の手順に従って実行ファイル「hello」を生成します
  - run: helloを実行します
  - clean: 生成したファイルを削除します

## make オプション
  - platform: see https://github.com/ReadyTalk/avian
  - arch: see https://github.com/ReadyTalk/avian
  - openjdk: see https://github.com/ReadyTalk/avian
