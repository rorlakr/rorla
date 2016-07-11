class Newsletter < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  mount_uploader :poster, PosterUploader

  belongs_to :editor, class_name: 'User'

  validates :title, presence: true

  has_many :articles, dependent: :destroy

  def self.subscribed?(email)
    mailgun = Mailgun()
    members = Mailgun::MailingList::Member.new mailgun, "newsletter_subscribers@#{ENV['domain']}"
    begin
      members.find email
    rescue => e
       false
    end
  end

  def self.subscribe(email)
    mailgun = Mailgun()
    if subscribed?(email)
      false
    else
      members = Mailgun::MailingList::Member.new mailgun, "newsletter_subscribers@#{ENV['domain']}"
      begin
        members.add(email)
        "added"
      rescue => e
        "이메일 주소를 확인하세요."
      end
    end
  end

  def self.unsubscribe(email)
    mailgun = Mailgun()
    if subscribed?(email)
      members = Mailgun::MailingList::Member.new mailgun, "newsletter_subscribers@#{ENV['domain']}"
      members.remove(email)
    else
      false
    end
  end
end
