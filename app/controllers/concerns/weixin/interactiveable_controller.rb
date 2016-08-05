module Weixin
  module InteractiveableController
    extend ActiveSupport::Concern

    included do
      before_action :weixin_signed_in_required
      before_action :weixin_binded_required

      before_action :participation_required, only: [:new, :create]
      before_action :not_participated_required, only: [:new, :create]
      before_action :lecturer_required, only: [:index]
    end
  end
end
