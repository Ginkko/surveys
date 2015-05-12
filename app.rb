require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/survey"
require "./lib/question"

get '/' do
  erb :index
end

get '/surveys' do
  @surveys = Survey.all
  erb :surveys
end

post '/surveys' do
  @surveys = Survey.all
  Survey.create(name: params.fetch('survey_name'))
  erb :surveys
end

get '/questions' do
  @questions = Question.all
  erb :questions
end

post '/questions' do
  @questions = Question.all
  Question.create(content: params.fetch('question_name'))
  erb :questions
end
