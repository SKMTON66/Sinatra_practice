# メモアプリ
『[Sinatra を使ってWebアプリケーションの基本を理解する](https://bootcamp.fjord.jp/practices/157)』の提出課題です。

## ◎インストール方法
作業PCの任意のディレクトリに `git clone`してください。

```zsh
git clone https://github.com/SKMTON66/Sinatra_practice.git
cd Sinatra_practice
```

下記のコマンドを入力

```zsh
git switch db-dev-branch
```

最後に下記のコマンドを実行します。

```zsh
bundle install
```

## ◎下準備

[PostgreSQL](https://www.postgresql.org/)をhomebrewを使ってインストールする。(postgresql@18 で動作確認済)

下記の手順でコマンドを実行していく
```zsh
brew services start postgresql@18 #インストールしたバージョンを指定
```

```zsh
ruby create_db_and_table.rb
```

## ◎利用方法

`Sinatra_practice`ディレクトリ内で下記のコマンドを実行するとSinatraが起動します。

```zsh
bundle exec ruby app.rb 
```

ブラウザで下記のURLにアクセスすると、メモアプリのトップページ(メモ一覧)が表示されます。

```
http://localhost:4567
```