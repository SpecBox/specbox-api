# specbox_api

### docker-composeを利用した起動

テスト用postgresとluckyのコンテナが立ち上がり、`lucky dev`が実行されてluckyの開発サーバが起動します。

`docker-compose up`

### docker-compose内のluckyに対するタスク実行

luckyコマンドの各タスクをdocker-compose内のluckyに対して実行します。
事前に`docker-compose up`の実行が必要です。

例
`./dc-lucky.sh --help`

This is a project written using [Lucky](https://luckyframework.org). Enjoy!

### Setting up the project

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app

### Using Docker for development

1. [Install Docker](https://docs.docker.com/engine/install/)
1. Run `docker compose up`

The Docker container will boot all of the necessary components needed to run your Lucky application.
To configure the container, update the `docker-compose.yml` file, and the `docker/development.dockerfile` file.


### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).
