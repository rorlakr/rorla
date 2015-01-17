class UserMailer < ActionMailer::Base
  default :from => "rorlakr@gmail.com"
 
  def password_reset(user)
    mail(:to => user.email,
         :subject => 'RORLab 비밀번호 재설정 요청')
  end
end