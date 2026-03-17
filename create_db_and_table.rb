# frozen_string_literal: true

require 'pg'

PG.connect(dbname: 'postgres') { it.exec('CREATE DATABASE sinatra_practice') }
PG.connect(dbname: 'sinatra_practice') do |conn|
  conn.exec(<<SQL)
  CREATE TABLE memo (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(500)
  )
SQL
end
