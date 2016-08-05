class Image < ActiveRecord::Base
  mount_uploader :file, FileUploader

  def self.policy_class
    ApplicationPolicy
  end
end
