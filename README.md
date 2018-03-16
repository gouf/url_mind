[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

# Tools

* [Rubocop](https://github.com/bbatsov/rubocop) を使っています

  作業の一区切りやコミット前にチェック・修正をしてみてください

* [ZenHub](https://www.zenhub.com/) をプロジェクト管理に利用しています

  Google Chrome, Firefox ブラウザ拡張が配布されているのでインストールしてください

* [Guard](https://github.com/guard/guard) を使用しています

  ローカル環境に於けるTDD(Test Drive Development) 実践補助, Rubocop によるスタイルチェック違反に対して早期に気づけるようになっているので、利用してみてください (`bundle exec guard` で立ち上げます)

# README

Things you may want to cover:

* Ruby version: 2.5.0

* Configuration

* Database engine

  For Test, Development: SQLite3

  For Production: PostgreSQL

* Database creation/initialization

  ```
  bundle exec rails db:migrate
  ```

* How to run the test suite

  ```sh
  bundle exec rspec # OR...
  bundle exec guard
  ```
* Services (job queues, cache servers, search engines, etc.)

  ```sh
  # Rails ActiveJob
  bundle exec rails job:dispatch_duplicated_url_deletion  # Delete ReadLater record that duplicate URL
  ```
* Deployment instructions

  1. Create Heroku app or, click Deploy to Heroku button on top of README.md and follow instructions.
  2. Set Heroku Scheduler for `dispatch_duplicated_url_deletion` job if you need.
