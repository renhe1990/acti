class AddWechatNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wechat_nickname, :string
  end
end
