require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  # 하루 한번 팟캐스트 목록 업데이트
  every(1.day, 'podcasts.grap') { 
    puts `bin/rake podcasts:grap`
  }
  every(1.hour, 'merit.hourly_cron_job') { 
    puts `bin/rake merit:hourly_cron_job`
  }
end
