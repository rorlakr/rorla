# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'rorla'
set :repo_url, 'git@github.com:rorlakr/rorla.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/rorlab/www/rorla'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')


# rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma}
set :rbenv_roles, :all

# bundler
set :bundle_jobs, 4

before 'deploy:check:linked_files', 'config:push'

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :bundler do
  before :install, :bundle_config do
    on fetch(:bundle_servers) do
      within release_path do
        execute :bundle, 'config mirror.https://rubygems.org https://ruby.taobao.org'
      end
    end
  end
end
