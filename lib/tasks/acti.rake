namespace :acti do
  task :cleanup => :environment do
    Rake::Task["acti:remove_campaigns_without_project"].execute
    Rake::Task["acti:remove_courses_without_existing_campaign"].execute
  end

  task :remove_campaigns_without_project => :environment do
    Campaign.all.reject(&:project).each(&:destroy)
  end

  task :remove_courses_without_existing_campaign => :environment do
    Course.all.select do |course|
      next if course.campaign_id.nil?

      !Campaign.where(id: course.campaign_id).first
    end.each(&:destroy)
  end

  task :fix_reviews_and_answers_in_opinionnaire, [:opinionnaire_id] => [:environment] do |task, args|
    opinionnaire = Opinionnaire.find args.opinionnaire_id
    opinionnaire.attempts.each do |attempt|
      opinionnaire.update_reviews_and_answers(attempt.participant, attempt.id)
      reviews = attempt.reviews.reload
      reviewable_ids = reviews.map(&:reviewable_id)
      duplicate_ids = reviewable_ids.select do |id| reviewable_ids.count(id) > 1 end.uniq
      next if duplicate_ids.blank?
      duplicate_ids.each do |id|
        duplicates = reviews.select{|review| review.reviewable_id == id}
        duplicates.pop
        duplicates.each(&:destroy)
      end
    end
  end
  task :keep_db_connect => :environment do
    #sql = 'SELECT SYSDATE() FROM DUAL'
    #results = ActiveRecord::Base.connection().execute(sql)
	#puts "如果显示这行字就说明task被执行了，执行结果：" << results.first.to_s
    results = Role.all
	puts "如果显示这行字就说明task被执行了，执行结果：" << results.to_s
  end
end
