require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require 'pg'
require 'pry'
require './lib/survey'
require './lib/question'
require './lib/answer'

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

get '/surveys/:id' do
  @survey = Survey.find(params.fetch('id').to_i)
  @questions = Question.all
  @questions_survey = @survey.questions
  erb :survey
end

get '/questions/:id' do
  @question = Question.find(params.fetch('id').to_i)
  @surveys = Survey.all
  @surveys_question = @question.surveys
  erb :question
end

patch '/surveys/:id' do
  survey_id = params.fetch('id').to_i
  @survey = Survey.find(survey_id)
  question_ids = params.fetch('question_ids')
  @survey.update({question_ids: question_ids})
  @questions = Question.all
  @questions_survey = @survey.questions
  erb :survey
end

patch '/surveys/:id/update' do
  @survey = Survey.find(params.fetch('id').to_i)
  @questions = Question.all
  @questions_survey = @survey.questions
  @survey.update({name: params.fetch('survey_name')})
  erb :survey
end

patch '/questions/:id' do
  @question = Question.find(params.fetch('id').to_i)
  survey_ids = params.fetch('survey_ids')
  @question.update({survey_ids: survey_ids})
  @surveys = Survey.all
  @surveys_question = @question.surveys
  erb :question
end

patch '/questions/:id/update' do
  @question = Question.find(params.fetch('id').to_i)
  @surveys = Survey.all
  @surveys_question = @question.surveys
  @question.update({content: params.fetch('question_content')})
  erb :question
end

delete '/surveys/:id/delete' do
  Survey.find(params.fetch('id').to_i).delete
  @surveys = Survey.all
  erb :surveys
end

delete '/questions/:id/delete' do
  Question.find(params.fetch('id').to_i).delete
  @questions = Question.all
  erb :questions
end

get '/take-survey' do
  @surveys = Survey.all
  erb :take_survey
end

get '/take-survey/:id' do
  @survey = Survey.find(params.fetch('id'))
  @questions = @survey.questions
  erb :answers
end

post '/take-survey/:id/finished' do
  survey = Survey.find(params.fetch('id'))
  questions = survey.questions
  questions.each do |question|
    Answer.create({answer: params.fetch(question.id.to_s), question_id: question.id})
  end
  @answers = Answer.all
  erb :complete_survey
end
