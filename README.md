# メモアプリ
『[Sinatra を使ってWebアプリケーションの基本を理解する](https://bootcamp.fjord.jp/practices/157)』の提出課題です。

## ◎インストール方法
作業PCの任意のディレクトリに `git clone`してください。

```zsh
git clone https://github.com/SKMTON66/Sinatra_practice.git
cd Sinatra_practice
```

下記の手順でコマンドを入力していく

```zsh
git fetch origin pull/1/head:pr-branch
```

```zsh
git switch pr-branch
```


最後に下記のコマンドを実行します。

```zsh
bundle install
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