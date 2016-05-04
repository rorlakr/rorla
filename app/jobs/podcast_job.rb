class PodcastJob
  # include SuckerPunch::Job
  queue_as :default


  # PodcastJob.new.async.perform
  def perform
    puts `bin/rake podcasts:grap`
  end
end
