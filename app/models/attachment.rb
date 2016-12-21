class Attachment < DatabaseConnection
  mount_uploader :asset, FileUploader

  belongs_to :attachable, polymorphic: true

  before_save :update_asset_attributes

  def to_jq_upload
    {
      "url" => asset.url,
      "delete_url" => id,
      "file_id" => id,
      "delete_type" => "DELETE"
    }
  end

  def self.policy_class
    ApplicationPolicy
  end

  private
  def update_asset_attributes
    if asset.present? && asset_changed?
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
  end
end
