namespace :merit do
  desc "랭킹 정보를 DB에 반영. 이미 반영된건이더라도 변경된 내용 업데이트됨"
  task :hourly_cron_job => :environment do
    Merit::RankRules.new.check_rank_rules
  end
end