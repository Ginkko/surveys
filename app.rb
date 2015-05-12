require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require 'pg'
require 'pry'
require './lib/survey'
require './lib/question'

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
  @surveys_question = @question.survey
  erb :question
end

patch '/surveys/:id' do
  @survey = Survey.find(params.fetch('id').to_i)
  selected_questions = []
  if(params.has_key?('question_ids'))
    params.fetch('question_ids').each do |question_id|
      selected_questions.push(Question.find(question_id.to_i))
    end
    selected_questions.each do |question|
      question.update({survey_id: params.fetch('id')})
    end
  end
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
  if(params.has_key?('survey_ids'))
    params.fetch('survey_ids').each do |survey_id|
      @question.update({survey_id: survey_id.to_i})
    end
  end
  @surveys = Survey.all
  @surveys_question = @question.survey
  erb :question
end
