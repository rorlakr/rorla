class Runners::WeeklynewsRunner
  def self.update
    gb = Gibbon::API.new
    campaigns = gb.campaigns.list({:start => 0, :limit => 100})
    if campaigns["total"] > 0
      campaigns["data"].each do |campaign|
        uid = campaign["id"]
        news = Weeklynews.where(uid: uid).first_or_initialize
        news.subject = campaign["subject"]
        news.sended_at = campaign["send_time"]
        news.url = campaign["archive_url_long"]
        news.save!
      end
    end
  end
end