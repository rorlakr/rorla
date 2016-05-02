namespace :weeklynews do
  desc 'run some rake db task'
  task :update do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "weeklynews:update"
        end
      end
    end
  end
end
