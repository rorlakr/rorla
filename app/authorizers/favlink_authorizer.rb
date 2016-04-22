class FavlinkAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user, options={})
    user.has_role?(:user) || user.has_role?(:admin)
  end

  def updatable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

end
