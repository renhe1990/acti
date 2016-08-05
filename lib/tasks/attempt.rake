namespace :attempt do
  task :collect_scores => :environment do
    Survey::Attempt.find_each do |attempt|
      attempt.send(:collect_scores)
    end
  end
end
