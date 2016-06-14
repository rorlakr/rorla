namespace :glossary do
  desc '용어집 업데이트'
  task :update, [:filename, :email] do | t, args |
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "import_glossary[args[:filename], args[:email]]"
        end
      end
    end
  end
end
