# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'pg'

DB_CONNECTION = PG.connect(dbname: 'sinatra_practice')

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def fetch_memo_data(id)
  db_result = DB_CONNECTION.exec("SELECT * FROM memo WHERE id = #{id}")
  memo = db_result[0]
  @id = memo['id']
  @title = memo['title']
  @content = memo['content']
end

get '/' do
  redirect '/memos'
end

get '/new-memo' do
  erb :new_memo
end

get '/memos' do
  @db_result = DB_CONNECTION.exec('SELECT * FROM memo')
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
  DB_CONNECTION.exec("INSERT INTO memo (title, content) VALUES ('#{params[:title]}', '#{params[:content]}')")
  redirect '/memos'
end

delete '/memos/:id' do |id|
  DB_CONNECTION.exec("DELETE FROM memo WHERE id = #{id}")
  redirect '/memos'
end

patch '/memos/:id' do |id|
  DB_CONNECTION.exec("UPDATE memo SET title = '#{params[:title]}', content = '#{params[:content]}' WHERE id = #{id}")
  redirect "/memos/#{id}"
end
