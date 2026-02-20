require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pathname'
require 'securerandom'

get '/' do
  erb :new_memo
end

post '/memos' do
  @title = params[:title]
  @content = params[:content]
  json_file = params.to_json # paramsをJSONに変換
  file = File.open("./json_files/#{params[:title]}.json", 'w') # wモードで開いた際、該当ファイルがなければ自動で作成する
  file.write("#{json_file}") # 書き込む内容
  file.close
  # `file = ~ close`までが `<タイトル>.json`という名前でjson_filesディレクトリに保存する一連の処理
  erb :show_memo
end
