def add_enviroment
  envs = []
  envs << "-e SECRET_KEY_BASE=\"#{ENV['RORLA_SECRET_KEY_BASE']}\""
  envs.join(' ')
end

def add_link
  links = []
  links << "--link mysql:mysql"
  links.join(' ')
end

def add_option
  "#{add_link} #{add_enviroment}"
end

def build_name(tag)
  "rorla/rorla:#{tag}"
end

def docker_console(tag)
  "docker run -i -t --rm #{add_option} #{build_name(tag)}"
end

namespace :docker do
  desc "도커 이미지 빌드"
  task :build, [:tag] => [:environment] do |t, args|
    tag = args[:tag]
    # 도커의 캐쉬가 명령어 기반이라서 해당 부분의 문자열을 바꿔주어 그 이후부터 캐쉬 이용하지 않도록함. https://github.com/dotcloud/docker/issues/1996
    system("sed -i '' s/CACHE_BUSTER_[0-9]*/CACHE_BUSTER_#{Time.now.to_i}/g Dockerfile")
    system("docker build --force-rm -t #{build_name(tag)} .")
  end

  desc "도커 컨테이너 시작 명령어 출력. RORLA_SECRET_KEY_BASE 환경변수 설정필요"
  task :start, [:tag] => [:environment] do |t, args|
    tag = args[:tag]
    command = "docker run --name #{tag} #{add_option} -d -p 80:80 #{build_name(tag)}"
    puts command
  end

  desc "도커 컨테이너 콘솔 실행용 명령어 출력. RORLA_DATABASE_URL, RORLA_SECRET_KEY_BASE 환경변수 설정필요"
  task :console, [:tag] => [:environment] do |t, args|
    tag = args[:tag]
    command = "#{docker_console(tag)}"
    puts command
  end

  desc "도커 컨테이너 db migrate 실행용 명령어 출력. RORLA_DATABASE_URL, RORLA_SECRET_KEY_BASE 환경변수 설정필요"
  task :migrate, [:tag] => [:environment] do |t, args|
    tag = args[:tag]
    command = "#{docker_console(tag)} bundle exec rake db:migrate"
    puts command
  end
end