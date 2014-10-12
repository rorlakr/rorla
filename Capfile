# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/rbenv'
require 'capistrano/rbenv_install'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/rails/console'
require 'capistrano/rails/collection'
require 'capistrano/unicorn_nginx'
require 'capistrano/rails_tail_log'
require 'capistrano/secrets_yml'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
