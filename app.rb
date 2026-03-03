# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

MEMOS_DATA_PATH = './public/memos.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def get_memo_data(id)
  memos = load_memos
  memo = find_memo(memos, id)
  @id = id
  @title = memo[:"#{id}"][:title]
  @content = memo[:"#{id}"][:content]
end

def save_memos(memos)
  File.open(MEMOS_DATA_PATH, 'w') { it.write(JSON.dump(memos)) }
end

def load_memos
  JSON.load_file(MEMOS_DATA_PATH, symbolize_names: true)
end

def find_memo(memos, id)
  memos.find { it.key?(:"#{id}") }
end

get '/' do
  redirect '/memos'
end

get '/new-memo' do
  erb :new_memo
end

get '/memos' do
  @memos = load_memos
  erb :memos
end

get '/memos/:id' do |id|
  get_memo_data(id)
  erb :show_memo
end

get '/memos/:id/edit' do |id|
  get_memo_data(id)
  erb :edit_memo
end

post '/memos' do
  memos = load_memos
  params[:id] = SecureRandom.uuid
  memo = { params[:id] => { title: params[:title], content: params[:content] } }
  memos << memo
  save_memos(memos)
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do |id|
  memos = load_memos
  memos.reject! { it.key?(:"#{id}") }
  save_memos(memos)
  redirect '/memos'
end

patch '/memos/:id' do |id|
  memos = load_memos
  memo = find_memo(memos, id)
  memo[:"#{id}"] = { title: params[:title], content: params[:content] }
  save_memos(memos)
  redirect "/memos/#{params[:id]}"
end
