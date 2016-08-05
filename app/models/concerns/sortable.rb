module Sortable
  extend ActiveSupport::Concern

  included do
    default_scope { order("position ASC") }
  end
end
