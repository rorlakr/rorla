class BulletinAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user, options={})
    user.has_role?(:admin)
  end

end
