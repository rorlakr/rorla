require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  # 하루 한번 팟캐스트 목록 업데이트
  every(1.day, 'podcasts.grap') { 
    puts `bin/rake podcasts:grap`
  }
end