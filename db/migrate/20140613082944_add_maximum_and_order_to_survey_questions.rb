class AddMaximumAndOrderToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :maximum, :integer
    add_column :survey_questions, :order, :string, default: 'asc'
  end
end
