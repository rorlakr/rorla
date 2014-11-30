class WeeklynewsJob
  include SuckerPunch::Job

  # WeeklynewsJob.new.async.perform
  def perform
    Runners::WeeklynewsRunner.update
  end
end