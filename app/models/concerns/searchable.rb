module Searchable
  extend ActiveSupport::Concern

  included do
    scope :by_keyword, ->(keyword) { where("LOWER(name) LIKE ?", "%#{keyword.downcase}%") }
  end
end
