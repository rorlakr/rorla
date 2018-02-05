namespace :master_key do
  desc 'upload config/master.key to remote server'
  task :upload do
    on roles(:app) do
      upload! StringIO.new(File.read("config/master.key")), "#{release_path}/config/master.key"
    end
  end
end
