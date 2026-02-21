# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pathname'
require 'securerandom'
require 'fileutils'

JSON_DIR_PATH = './json_files/'

FileUtils.mkdir_p(JSON_DIR_PATH)

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def build_file_path(params)
    "#{JSON_DIR_PATH}#{params[:id]}.json"
  end

  def make_json_file(params)
    memo = {
      "title": params[:title],
      "content": params[:content],
      "id": params[:id]
    }
    File.open(build_file_path(params), 'w') do |file|
      file.write(JSON.pretty_generate(memo))
    end
  end

  def parse_json(params)
    JSON.parse(File.read(build_file_path(params)), symbolize_names: true)
  end
end

get '/' do
  redirect '/memos'
end

get '/new-memo' do
  erb :new_memo
end

get '/memos' do
  directry_path = Pathname.new(JSON_DIR_PATH)
  json_files = directry_path.glob('*.json')
  @memos = json_files.map do |json_file|
    JSON.parse(json_file.read, symbolize_names: true)
  end
  erb :memos
end

get '/memos/:id' do
  @memo = parse_json(params)
  erb :show_memo
end

get '/memos/:id/edit' do
  @memo = parse_json(params)
  erb :edit_memo
end

post '/memos' do
  params[:id] = SecureRandom.uuid
  make_json_file(params)
  redirect '/memos'
end

delete '/memos/:id' do
  File.delete(build_file_path(params))
  redirect '/memos'
end

patch '/memos/:id' do
  make_json_file(params)
  redirect "/memos/#{params[:id]}"
end
