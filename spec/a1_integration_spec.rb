require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'The path to add surveys', :type => :feature do
  it 'will let the user click a button to add a survey, enter the survey name, submit the survey, and see it as an output' do
    visit '/'
    click_link 'list_surveys'
    fill_in 'survey_name', :with => 'Places in the world'
    click_button 'submit_survey'
    expect(page).to have_content('Places in the world')
  end
end
