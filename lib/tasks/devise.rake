# 참고 https://gist.github.com/willywg/1160873
namespace :devise do
  desc 'create user and password reset'
  task :create_and_password_reset, [:user_email] => [:environment] do |t, args|
    begin
      email = args[:user_email]
      user = User.where(email: email).first
      raise "SKIP User(#{args[:user_email]}) is already signed" if !user.nil?

      if user.nil?
        user = User.create!(email: email, 
                password: Devise.friendly_token, 
                confirmed_at: Time.now)
        UserMailer.password_reset(user).deliver
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    end
  end

  desc 'Mass password reset'
  task :mass_create_and_password_reset => :environment do
    File.open('tmp/old_user_email.csv', 'r:UTF-8') do |f|
      f.each do |email|
        task = "devise:create_and_password_reset"
        Rake::Task[task].reenable
        Rake::Task[task].invoke(email.strip)
      end
    end
  end
end