require "spec_helper"

describe(Question) do
  it('tells what questions are attached to a survey') do
    survey = Survey.create({name: "Eating Habits"})
    question = Question.create({content: "What did you eat for dinner?", survey_id: survey.id})
    expect(survey.questions).to eq([question])
  end
end
