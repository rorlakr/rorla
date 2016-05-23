class UserMailer < ActionMailer::Base
  default :from => "rorlakr@gmail.com"

  def password_reset(user)
    mail(:to => user.email,
         :subject => '[RORLAB] 비밀번호 재설정 요청')
  end

  def confirm_purchase_request(user)
    mail(:to      => user.email,
         :subject => '[RORLAB] 구매신청이 완료되었습니다.')
  end

  def confirm_application(user, applier)
    @applier = applier
    mail(:to      => user.email,
         :bcc => User.with_role(:contributor).pluck(:email),
         :subject => "[RORLAB] #{@applier.schedule.name} 참가신청 완료")
  end

  def confirm_application_withdraw(user)
    mail(:to      => user.email,
         :bcc => User.with_role(:contributor).pluck(:email),
         :subject => "[RORLAB] 참가신청 취소")
  end

  def confirm_application_accept(user, applier)
    @applier = applier
    mail(:to      => user.email,
         :bcc => User.with_role(:contributor).pluck(:email),
         :subject => "[RORLAB] #{@applier.schedule.name} 참가 최종 승인")
  end

end
