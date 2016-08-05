module Admin::VotesHelper
  def vote_answers_in_xls(vote_result, vote_item)
    result = vote_item.vote_item_options & vote_result.vote_result_items.map(&:vote_item_option)
    if result.present?
      result.first.text
    else
      '/'
    end
  end
end
