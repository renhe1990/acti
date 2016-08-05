class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :photoable, polymorphic: true

  before_save :update_image_attributes

  def to_jq_upload
    {
      "url" => image.url,
      "delete_url" => id,
      "file_id" => id,
      "delete_type" => "DELETE"
    }
  end

  def self.policy_class
    ApplicationPolicy
  end

  private
  def update_image_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
    end
  end
end
