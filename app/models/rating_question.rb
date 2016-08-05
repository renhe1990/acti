class RatingQuestion < Survey::Question
  def average_rating(reviewable = nil)
    scope = answers
    scope = scope.joins(:review).where("reviews.reviewable_id = ?", reviewable.id) if reviewable
    scope.where.not(attempt_id: nil).average(:rating)
  end

  def statistics(reviewable = nil)
    result = {
      '75-100' => 0,
      '50-74' => 0,
      '25-49' => 0,
      '0-24' => 0
    }
    scope = answers
    scope = scope.joins(:review).where("reviews.reviewable_id = ?", reviewable) if reviewable
    scope.where.not(attempt_id: nil).inject(result) do |hash, answer|
      case answer.rating
      when 0..24
        hash['0-24'] += 1
      when 25..49
        hash['25-49'] += 1
      when 50..74
        hash['50-74'] += 1
      when 75..100
        hash['75-100'] += 1
      end
      hash
    end
  end
end
