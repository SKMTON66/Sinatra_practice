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
  json_file = params.to_json
  file = File.open("./json_files/#{SecureRandom.uuid}.json", 'w')
  file.write("#{json_file}")
  file.close
  erb :show_memo
end
