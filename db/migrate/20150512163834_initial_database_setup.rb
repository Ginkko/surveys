class InitialDatabaseSetup < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:name, :string)
    end
    create_table(:questions) do |t|
      t.column(:content, :string)
      t.column(:survey_id, :int)
    end
  end
end
