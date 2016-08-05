module Admin::Sortable
  extend ActiveSupport::Concern

  included do
    skip_after_action :verify_authorized, only: [:sort]
    skip_after_action :verify_policy_scoped, only: [:sort]
  end

  def sort
    params[controller_name].each_with_index do |id, index|
      controller_name.singularize.classify.constantize.find(id).update_column(:position, index + 1)
    end
    render nothing: true
  end
end
