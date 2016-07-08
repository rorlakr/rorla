class UserMailer < ActionMailer::Base

  helper :application
  helper :glossaries
  helper :newsletters
  helper :mailer
  helper Devise::Controllers::Helpers

  default :from => "rorlakr@gmail.com"

  def password_reset(user)
    mail(:to => user.email,
         :subject => '[RORLAB] 비밀번호 재설정 요청')
  end

  def send_newsletter(user, newsletter)
    @newsletter = newsletter
    mail(:to      => user.email,
         :subject => '[RORLAB] 뉴스레터')
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

  def confirm_comment_sent(user, comment)
    # 이웃 댓글을 작성한 사람에게도 추가된 댓글을 알려 준다
    commenters = comment.commentable.comments.map { | comment | comment.writer.email }.uniq
    # RORLAB 운영자에게도 알려 준다
    contributors = User.with_role(:contributor).pluck(:email).uniq
    cc = comment.commentable.try(:user).try(:email) ||
         comment.commentable.try(:writer).try(:email) ||
         comment.commentable.try(:tutor).try(:email)
    bcc = (commenters + contributors).uniq
    @comment = comment
    mail(:to      => user.email,
         :cc      => cc,
         :bcc     => bcc,
         :subject => "[RORLAB] 댓글이 등록되었습니다.")
  end


end
