namespace :cron do
  desc "Clears sessions that have not been accessed for a month"
  task clear_sessions: :environment do
    Session.where("accessed_at <= ?", 1.month.ago).destroy_all
  end
end
