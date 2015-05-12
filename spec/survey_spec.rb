require "spec_helper"

describe(Survey) do
  it('tells what questions are attached to a survey') do
    survey = Survey.create({name: "Eating Habits"})
    question = Question.create({content: "What did you eat for dinner?", survey_id: survey.id})
    expect(survey.questions).to eq([question])
  end

  it('will change the name of a survey to titlecase on creation') do
    survey = Survey.create({name: "eaTinG haBIts"})
    expect(survey.name).to eq("Eating Habits")
  end
end
