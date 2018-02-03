# config valid only for current version of Capistrano
lock Capistrano::VERSION
# lock '3.5.0'
# lock '3.4.1'

set :application, 'rorla'
set :repo_url, 'git@github.com:rorlakr/rorla.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/www/rorla'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :format_options, banner: :auto, command_output: false

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.5.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma}
set :rbenv_roles, :all

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')

before 'deploy:check:linked_files', 'config:push'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'nginx:reload'

namespace :deploy do
  task :restart do
    invoke 'delayed_job:restart'
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

# namespace :bundler do
#   before :install, :bundle_config do
#     on fetch(:bundle_servers) do
#       within release_path do
#         execute :bundle, 'config mirror.https://rubygems.org https://ruby.taobao.org'
#       end
#     end
#   end
# end
