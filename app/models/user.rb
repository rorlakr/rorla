# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  has_merit

  rolify
  include Authority::UserAbilities
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :rblogs, foreign_key: :writer_id, dependent: :destroy
  has_many :posts, foreign_key: :writer_id, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bundlelinks, foreign_key: :writer_id, dependent: :nullify
  has_many :favlinks, foreign_key: :writer_id, dependent: :destroy
  has_and_belongs_to_many :useful_answers, class_name: "Answer", join_table: :useful_answers

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    self.add_role :user
  end

  def account_name
    email.split('@').first
  end

end
