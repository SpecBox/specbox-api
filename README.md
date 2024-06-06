# specbox_api

## 開発

### docker-composeによる開発環境構築

テストもDockerコンテナ内で手軽に実行できるように、テスト用のdocker-composeのserviceを用意しています。
また、開発サーバとテストでDBの状態が共有されないように、DBについても開発サーバ用とテスト用のserviceを分けています。

**開発サーバ用service**
postgresとluckyのコンテナが起動し、`lucky dev`が実行されてluckyの開発サーバが起動します。

- 開発サーバの立ち上げ: `docker-compose up lucky` または `./server-docker-fore.sh`
- 開発サーバをバックグランドで立ち上げ: `docker-compose up -d luck` または `./server-docker-daemon.sh`

**テスト用service**
テスト用postgresとテスト用luckyのコンテナが起動し、`crystal spec`が実行されます。

- テストの実行: `docker-compose up lucky_test` または `./test-docker.sh`


### docker-compose内のluckyに対するタスク実行

`./dc-lucky.sh [options]`

luckyコマンドの各タスクをdocker-compose内のluckyに対して実行します。
事前に前述のコマンドによる開発サーバの立ち上げが必要です。

例
`./dc-lucky.sh --help`

## This is a project written using [Lucky](https://luckyframework.org). Enjoy!

### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).
