class AddWechatBackgroundToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :wechat_background, :string
  end
end
