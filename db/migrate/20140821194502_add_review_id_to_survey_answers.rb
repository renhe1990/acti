class AddReviewIdToSurveyAnswers < ActiveRecord::Migration
  def change
    add_column :survey_answers, :review_id, :integer, index: true
  end
end
