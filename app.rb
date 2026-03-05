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

def save_memos(memos)
  File.open(MEMOS_DATA_PATH, 'w') { it.write(JSON.dump(memos)) }
end

def load_memos
  JSON.load_file(MEMOS_DATA_PATH, symbolize_names: true)
end

def fetch_memo_data(id)
  memos = load_memos
  @id = id
  @title = memos[id.to_sym][:title]
  @content = memos[id.to_sym][:content]
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
  fetch_memo_data(id)
  erb :show_memo
end

get '/memos/:id/edit' do |id|
  fetch_memo_data(id)
  erb :edit_memo
end

post '/memos' do
  memos = load_memos
  id = SecureRandom.uuid
  memos[id] = { title: params[:title], content: params[:content] }
  save_memos(memos)
  redirect "/memos/#{id}"
end

delete '/memos/:id' do |id|
  memos = load_memos
  memos.delete(id.to_sym)
  save_memos(memos)
  redirect '/memos'
end

patch '/memos/:id' do |id|
  memos = load_memos
  memos[id.to_sym] = { title: params[:title], content: params[:content] }
  save_memos(memos)
  redirect "/memos/#{id}"
end
