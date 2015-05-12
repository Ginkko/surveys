require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/survey"
require "./lib/question"

get('/') do
  erb(:index)
end
