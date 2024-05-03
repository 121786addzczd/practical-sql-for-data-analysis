# PostgreSQL, CloudBeaver, Jupyter Notebookを使用したデータ分析環境

## 概要
このリポジトリは、PostgreSQL、CloudBeaver、Jupyter Notebookを使用したデータ分析のための完全なセットアップを提供します。各コンポーネントはDockerを使用してコンテナ化されており、分析環境の簡単なセットアップと再現性が可能です。

## コンポーネント
### PostgreSQLデータベース
- サービス名: db
- 概要: このサービスはPostgreSQLサーバーを提供し、初期設定スクリプトとデータセットを docker-entrypoint-initdb.d と /tmp/data_set にマウントします。ユーザー名、パスワード、データベース名が環境変数として設定されています。
- ポート: ローカルホストの5432番ポートを使用。

### CloudBeaver Webインターフェース
- サービス名: cloudbeaver
- 概要: CloudBeaverは、Webベースのデータベース管理ツールです。このサービスはデータベースとのやり取りを容易にし、ユーザーフレンドリーなインターフェースを提供します。
- ポート: 8978番ポートを使用。
- 依存関係: PostgreSQLデータベースが起動していること。

### Jupyter Notebook
- サービス名: notebook
- 概要: Jupyter Notebookは、ブラウザベースのインタラクティブ計算環境です。このサービスはデータ分析やビジュアライゼーションに使用され、複数のプログラミング言語をサポートします。
- ポート: ローカルホストの8888番ポートを使用。
- 環境設定: データベース接続情報が設定され、Jupyter Labが有効化されています。
- 依存関係: PostgreSQLデータベースが正常に稼働していること。

これらのサービスを使用して、データベース管理から分析、レポート作成まで、一貫したワークフローを容易に構築できます。各コンポーネントは互いに連携し、効率的なデータ分析環境を提供します。


## 環境構築
docker-compose.ymlと同じ階層にいることを確認して以下コマンドを実行してください。
```shell
docker compose up -d --build --wait
```


## 使用方法
- ブラウザで以下のURLにアクセスすることでnotebookが開けます
  - [http://localhost:8888](http://localhost:8888)

- ブラウザで以下のURLにアクセスすることでcloudbeaverからデータベースの情報が見れます
  - [http://localhost:8978](http://localhost:8978)
cloudbeaverの設定はdocker/doc/[cloudbeaver設定.mov](docker/doc/cloudbeaver設定.mov)を参照してください



## cli操作でpostgresqlにアクセス
analysis-postgres-dbコンテナが起動している状態で以下コマンドを実行し、postgresqlにログインします。
```shell
docker exec -it analysis-postgres-db psql -U brain -d analysis_postgres_db -h localhost -W
```
パスワード入力を求められますが、そのままエンターキー押下でログインできます。


以下コマンドでログインしたデータベースのテーブル一覧表示ができます。
```sql
\dt
```
