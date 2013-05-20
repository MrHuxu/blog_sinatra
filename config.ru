require 'bundler'
Bundler.require
require './main'
DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/articles.db")
run Sinatra::Application
