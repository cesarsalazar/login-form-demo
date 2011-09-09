require 'rubygems'
require 'rack-flash'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/redirect_with_flash'
require 'sinatra/reloader' if development?
require 'dm-core'
require 'dm-migrations'
require 'haml'
require 'sass'
require 'rdiscount'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.sqlite3")

class Something
  include DataMapper::Resource
  property  :id,    Serial
  property  :name,  String
end

DataMapper.auto_upgrade!

get '/' do
  haml :index
end

get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
