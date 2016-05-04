class WeeklynewsJob
  # include SuckerPunch::Job
  queue_as :default


  # WeeklynewsJob.new.async.perform
  def perform
    Runners::WeeklynewsRunner.update
  end
end
