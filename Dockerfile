FROM dockerfile/ubuntu
MAINTAINER seapy(iamseapy@gmail.com)

# Run upgrades
RUN apt-get update

# Install basic packages
RUN apt-get -qq -y install git curl build-essential openssl libssl-dev python-software-properties python g++ make

# Install imagemagick
RUN apt-get update
RUN apt-get -qq -y install libmagickwand-dev imagemagick

# Install Ruby 2.1
RUN apt-get -qq -y install python-software-properties
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get -qq --force-yes install ruby2.1 ruby2.1-dev
RUN gem install bundler --no-ri --no-rdoc

# Install packages
RUN apt-get install -qq -y libsqlite3-dev
RUN apt-get install -qq -y nodejs
RUN gem install foreman --no-ri --no-rdoc

# Install the latest postgresql lib for pg gem
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
#     apt-get update && \
#     DEBIAN_FRONTEND=noninteractive \
#     apt-get install -y --force-yes libpq-dev

# Install for mysql gem
RUN apt-get install -qq -y mysql-server mysql-client libmysqlclient-dev

# Install for Webshots
RUN apt-get install libssl0.9.8 -y
RUN apt-get install ttf-unfonts-core -y

# Install rails app
WORKDIR /app
## 캐쉬 방지용 echo. rake 에서 sed 이용해서 문자열 치환
RUN echo "CACHE_BUSTER_1405985185"
## 현재 폴더의 파일을 Add
ADD . /app

RUN bundle install --without development test

# Run docker-sample-project
ENV RAILS_ENV production
EXPOSE 80
CMD foreman start -f Procfile
