require 'pg'

PG.connect(dbname: 'postgres') do |conn| # PG::Connection.open(dbname: 'postgres') または PG::Connection.new(dbname: 'postgres')でも可能
  conn.exec('CREATE DATABASE sinatra_practice')
end

conn2 = PG.connect(dbname: 'sinatra_practice')
conn2.exec(<<SQL)
  CREATE TABLE memo (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(500)
  )
SQL
