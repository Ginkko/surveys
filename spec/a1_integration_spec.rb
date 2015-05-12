require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'The path to add surveys', :type => :feature do
  it 'will let the user click a button to add a survey, enter the survey name, submit the survey, and see it as an output' do
    visit '/'
    click_link 'list_surveys'
    fill_in 'survey_name', :with => 'Places In The World'
    click_button 'submit_survey'
    expect(page).to have_content('Places In The World')
  end
end

describe 'The path to add questions', :type => :feature do
  it 'will let the user click a button to add a question, enter the question name, submit the question, and see it as an output' do
    visit '/'
    click_link 'list_questions'
    fill_in 'question_name', :with => 'Do you like dags?'
    click_button 'submit_question'
    expect(page).to have_content('Do you like dags?')
  end
end

describe 'The path to get to a survey', type: :feature do
  it 'will let the user visit a specific survey.' do
    survey = Survey.create(name: 'Taco Time')
    visit '/surveys'
    click_link survey.name
    expect(page).to have_content('Survey: Taco Time')
  end
end

describe 'The path to get to a question', type: :feature do
  it 'will let the user visit a specific question.' do
    question = Question.create(content: 'What is your quest?')
    visit '/questions'
    click_link question.content
    expect(page).to have_content('Question: What is your quest?')
  end
end

describe 'The path to attaching questions to surveys', type: :feature do
  it 'will let the user select multiple questions from checkboxes and add them to a survey' do
    survey = Survey.create(name: 'Taco Time')
    question1 = Question.create(content: 'Soft or hardshell?')
    question2 = Question.create(content: 'Veggie, Beef, or Chicken?')
    visit '/surveys'
    click_link survey.name
    check(question1.id)
    check(question2.id)
    click_button('attach_questions')
    expect(page).to have_content('Attached Questions:')
    expect(page).to have_content('Soft or hardshell?')
    expect(page).to have_content('Veggie, Beef, or Chicken?')
  end
end

describe 'The path to alter surveys', type: :feature do
  before do
    survey = Survey.create(name: 'Taco Time')
    visit '/surveys'
    click_link survey.name
  end

  it 'will let the user update the survey' do
    fill_in 'survey_name', with: 'Dorito Time'
    click_button 'update_name'
    expect(page).to have_content 'Dorito Time'
  end

  it 'will let the user delete the survey' do
    click_button 'delete_survey'
    expect(page).to_not have_content 'Taco Time'
    expect(page).to have_content 'List of Surveys'
  end
end

describe 'The path to alter questions', type: :feature do
  before do
    question = Question.create(content: 'Taco Time?')
    visit '/questions'
    click_link question.content
  end

  it 'will let the user update the question' do
    fill_in 'question_content', with: 'Dorito Time?'
    click_button 'update_content'
    expect(page).to have_content 'Dorito Time?'
  end

  it 'will let the user delete the question' do
    click_button 'delete_question'
    expect(page).to_not have_content 'Taco Time?'
    expect(page).to have_content 'List of Questions'
  end
end
