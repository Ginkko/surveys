class CreatesSurveysQuestionsJoinTable < ActiveRecord::Migration
  def change
    create_table :questions_surveys, id: false do |t|
      t.integer :question_id
      t.integer :survey_id
    end
    add_index :questions_surveys, :survey_id
    add_index :questions_surveys, :question_id
  end
end
