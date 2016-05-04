class PodcastJob
  # include SuckerPunch::Job

  # PodcastJob.new.async.perform
  def perform
    puts `bin/rake podcasts:grap`
  end
end
