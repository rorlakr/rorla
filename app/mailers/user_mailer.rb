class UserMailer < ActionMailer::Base
  default :from => "rorlakr@gmail.com"

  def password_reset(user)
    mail(:to => user.email,
         :subject => 'RORLab 비밀번호 재설정 요청')
  end

  def confirm_purchase_request(user)
    mail(:to => user.email,
    :subject => 'RORLab 구매신청이 완료되었습니다.')
  end

end
