namespace :user do
  task :fetch_wechat_nickname => :environment do
    User.with_deleted.where.not(uid: nil).each do |user|
      wechat_user = Wechat.api.user user.uid
      user.update_column :wechat_nickname, wechat_user['nickname'] if wechat_user
    end
  end

  task :set_default_role => :environment do
    role = Role.first
    User.where(role_id: nil).each do |user|
      user.role = role
      user.save
    end
  end
end
