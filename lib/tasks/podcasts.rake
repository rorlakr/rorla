namespace :podcasts do
  desc "팟 캐스트 정보를 DB에 반영. 이미 반영된건이더라도 변경된 내용 업데이트됨"
  task :grap => :environment do
    res = Excon.get('http://rorlabpodcasts.github.io/posts.json')
    json = MultiJson.load(res.body)
    json["data"]["posts"].each do |item|
      uid = item["id"]
      podcast = Podcast.where(uid: uid).first_or_initialize
      podcast.title = item["title"]
      podcast.author = item["author"]
      podcast.description = item["content"]
      podcast.published_at = Date.parse item["published_at"]
      podcast.enclosure_url = item["video"]["url"]
      podcast.enclosure_size = item["video"]["size"]
      podcast.duration = item["video"]["duration"]
      podcast.save!
    end
  end
end