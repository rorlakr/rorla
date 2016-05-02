namespace :weeklynews do
  task setup_logger: :environment do
    logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    Rails.logger = logger
  end

  desc "팟 캐스트 정보를 DB에 반영. 이미 반영된건이더라도 변경된 내용 업데이트됨"
  task :update => :setup_logger do
    gb = Gibbon::API.new("d7be1222528f20795652293a1d97c9a7-us9")
    campaigns = gb.campaigns.list({:start => 0, :limit => 100})
    if campaigns["total"] > 0
      campaigns["data"].each do |campaign|
        uid = campaign["id"]
        news = Weeklynews.where(uid: uid).first_or_initialize
        news.subject = campaign["subject"]
        news.sended_at = campaign["send_time"]
        news.url = campaign["archive_url_long"]
        news.save!
        puts news.subject
      end
    end

    Rails.logger.info "END podcasts:grap"
  end
end
