class AddRatingToSurveyAnswers < ActiveRecord::Migration
  def change
    add_column :survey_answers, :rating, :integer
  end
end
