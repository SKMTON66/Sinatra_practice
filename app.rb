# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'pg'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def save_memo(mode:, params:)
  case mode
  when 'add'
    load_memos.exec_params('INSERT INTO memo (title, content) VALUES ($1, $2) RETURNING id', [params[:title], params[:content]])
  when 'edit'
    load_memos.exec_params('UPDATE memo SET title = $1, content = $2 WHERE id = $3', [params[:title], params[:content], params[:id]])
  end
end

def load_memos
  @load_memos ||= PG.connect(dbname: 'sinatra_practice')
end

def delete_memo(id)
  load_memos.exec_params('DELETE FROM memo WHERE id = $1', [id])
end

def fetch_memo_data(id)
  @memo = load_memos.exec_params('SELECT * FROM memo WHERE id = $1', [id])[0]
end

get '/' do
  redirect '/memos'
end

get '/new-memo' do
  erb :new_memo
end

get '/memos' do
  @memos = load_memos.exec('SELECT * FROM memo')
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
  id = save_memo(mode: 'add', params: params)[0]['id']
  redirect "/memos/#{id}"
end

delete '/memos/:id' do |id|
  delete_memo(id)
  redirect '/memos'
end

patch '/memos/:id' do |id|
  save_memo(mode: 'edit', params: params)
  redirect "/memos/#{id}"
end
