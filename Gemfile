source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'
gem 'acts_as_votable', '0.11.1'
gem 'ambry', '1.0.0'
gem 'authority', '3.3.0'
gem 'auto_html', '2.0.0'
gem 'autoprefixer-rails', '>= 6.0.3'
gem 'autosize', '2.4.0.0'
gem 'bh'
gem 'bootsnap', require: false
gem 'carrierwave-aws', '1.3.0'
gem 'clockwork', '2.0.2'
gem 'cocoon', '1.2.11'
gem 'codemirror-rails', '5.16.0'
gem 'coffee-rails'
gem 'daemons', '1.2.6'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.3'
gem 'delayed_job_web', '1.4.3'
gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'excon', '0.60.0'
gem 'fontawesome5-rails'
gem 'friendly_id', '~> 5.2', '>= 5.2.5'
gem 'gibbon', '3.2.0'
gem 'google-code-prettify-rails', github: 'luciuschoi/google-code-prettify-rails'
gem 'gravatar-ultimate', '2.0.0'
gem 'image_processing', '~> 1.2'
gem 'impressionist', '1.6.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-minicolors-rails', '~> 2.2', '>= 2.2.6.1'
gem 'jquery-tokeninput-rails', '1.6.0'
gem 'jquery-ui-rails', '6.0.1'
gem 'mailgun', '0.11'
gem 'markdown-rails', github: 'luciuschoi/markdown-rails'
gem 'meetup_client', '1.0.0'
gem 'merit', '3.0.1'
gem 'meta-tags'
gem 'multi_json', '1.13.1'
gem 'oj', '3.4.0'
gem 'pagedown-bootstrap-rails', '2.1.0', github: 'rorlab/pagedown-bootstrap-rails'
gem 'placeholdit', '0.0.5'
gem 'puma', '4.0.1'
gem 'rails', '~> 6.0.0.rc2'
gem 'recaptcha', '4.6.4', require: 'recaptcha/rails'
gem 'redcarpet', '3.4.0'
gem 'remotipart', '1.3.1'
gem 'rolify', '5.2.0'
gem 'sanitize', '4.6.0'
gem 'sass-rails', '~> 5'
gem 'search_cop', '1.0.9'
gem 'simple_enum', '2.3.0'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'validate_url', '1.0.2'
gem 'webpacker', '~> 4.0'
gem 'webshots', '0.0.1', github: 'rorlab/webshots'
gem 'will_paginate-bootstrap4'
gem 'xmlrpc', '0.3.0'
gem 'yaml_db', '~> 0.7.0'

gem "capistrano", "~> 3.11", require: false
gem 'capistrano-bundler', '~> 1.1'
gem 'capistrano-master-key', github: 'virgoproz/capistrano-master-key'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-rails-console', require: false
gem 'capistrano-rails-tail-log', '0.1.0'
gem 'capistrano-rbenv', '~> 2.1'
gem 'capistrano-rbenv-install', '1.2.0'
gem 'capistrano-upload-config', '0.8.2'
gem 'capistrano3-nginx', '3.0.4'
gem 'capistrano-yarn'
gem 'capistrano3-puma', '4.0.0'

group :production do
  gem 'mysql2', '0.5.2', group: :production
end

group :development do
  gem 'annotate', '~> 2.7', '>= 2.7.5'
  gem 'better_errors', '~> 2.5', '>= 2.5.1'
  gem 'binding_of_caller', '0.8.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd', '1.5.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3', '1.3.13'
  gem 'terminal-notifier-guard', '1.7.0'
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
  gem 'web-console', '~> 4.0'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '4.8.2'
  gem 'guard', '~> 2.1'
  gem 'guard-rspec', '4.7.3', require: false
  gem 'letter_opener', '1.6.0'
  gem 'rails-env-credentials'
  gem 'rspec-rails'
  gem 'spring-commands-rspec', '1.0.4'
end

group :test do
  gem 'capybara', '~> 3.25'
  gem 'capybara-webkit'
  gem 'webdrivers'
  gem 'database_cleaner', '1.6.2'
  gem 'faker', '1.8.7'
  gem 'launchy', '2.4.3'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '3.1.2', require: false
  gem 'simplecov', '0.15.1', require: false
  gem 'vcr', '4.0.0'
  gem 'webmock', '3.3.0'
end
