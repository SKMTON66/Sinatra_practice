require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pathname'
require 'securerandom'

get '/' do
  redirect '/memos'
end

get '/new-memo' do
  erb :new_memo
end

get '/memos' do
  dir = Pathname.new('./json_files')
  json_files = dir.glob('*.json')
  @files_data = json_files.map do |json_file|
    JSON.parse(json_file.read, symbolize_names: true)
  end
  erb :memos
end

post '/memos' do
  @title = params[:title]
  @content = params[:content]
  json_file = JSON.pretty_generate(params)
  file = File.open("./json_files/#{params[:id]}.json", 'w')
  file.write("#{json_file}")
  file.close
  redirect '/memos'
end
