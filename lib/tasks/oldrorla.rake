namespace :oldrorla do
  task setup_logger: :environment do
    logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    Rails.logger = logger
  end

  task user: :environment do
    @user = User.where(email: ENV["luciuschoi_email"]).first
    if @user.nil?
      throw "can't find user"
    end
  end

  desc "새소식 마이그레이션"
  task :news => [:setup_logger, :user] do
    bulletin = Bulletin.where(title: "새소식").first
    if bulletin.nil?
      throw "can't find news bulletin"
    end

    items = Oj.load(File.read('tmp/json/news.json'))
    items.each do |item|
      post = bulletin.posts.create(
        title: item[:title],
        content: item[:content],
        published: true,
        hit: item[:hit],
        writer: @user,
        published_at: item[:created_at],
        created_at: item[:created_at],
        updated_at: item[:updated_at]
      )
    end

    Rails.logger.info "END oldrorla:news"
  end

  desc "공지사항 마이그레이션"
  task :notice => [:setup_logger, :user] do
    bulletin = Bulletin.where(title: "공지사항").first
    if bulletin.nil?
      throw "can't find notice bulletin"
    end

    items = Oj.load(File.read('tmp/json/notice.json'))
    items.each do |item|
      post = bulletin.posts.create(
        title: item[:title],
        content: item[:content],
        published: true,
        hit: item[:hit],
        writer: @user,
        published_at: item[:created_at],
        created_at: item[:created_at],
        updated_at: item[:updated_at]
      )
    end

    Rails.logger.info "END oldrorla:notice"
  end

  desc "자료실(to rblogs) 마이그레이션"
  task :rblog => [:setup_logger, :user] do
    items = Oj.load(File.read('tmp/json/info.json'))
    items.each do |item|
      rblog = Rblog.create(
        title: item[:title],
        content: item[:content],
        shared: true,
        writer: @user,
        created_at: item[:created_at],
        updated_at: item[:updated_at]
      )

      item[:hit].times.each do
        Impression.create(
          impressionable_type: "Rblog", 
          impressionable_id: rblog.id, 
          user_id: @user.id, 
          controller_name: "rblogs", 
          action_name: "show", 
          request_hash: SecureRandom.hex(64), 
          session_hash: SecureRandom.hex(32), 
          ip_address: "127.0.0.1"
        )
      end
    end

    Rails.logger.info "END oldrorla:rblog"
  end

  desc "happyrails(to rblogs) 마이그레이션"
  task :happyrails => [:setup_logger, :user] do
    items = Oj.load(File.read('tmp/json/happyrails.json'))
    items.each do |item|
      rblog = Rblog.create(
        title: item[:title],
        content: item[:content],
        shared: true,
        writer: @user,
        created_at: item[:created_at],
        updated_at: item[:updated_at],
        tag_list: item[:tags]
      )

      item[:hit].times.each do
        Impression.create(
          impressionable_type: "Rblog", 
          impressionable_id: rblog.id, 
          user_id: @user.id, 
          controller_name: "rblogs", 
          action_name: "show", 
          request_hash: SecureRandom.hex(64), 
          session_hash: SecureRandom.hex(32), 
          ip_address: "127.0.0.1"
        )
      end
    end

    Rails.logger.info "END oldrorla:happyrails"
  end
end