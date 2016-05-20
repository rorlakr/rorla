class ScheduleAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.has_role?(:admin) || user.has_role?(:contributor)
  end

  def readable_by?(user)
    user.has_role?(:user) || user.has_role?(:admin) || user.has_role?(:contributor)
  end

  def updatable_by?(user)
    user.has_role?(:admin) || user.has_role?(:contributor)
  end

  def deletable_by?(user)
    user.has_role?(:admin) || user.has_role?(:contributor)
  end

end
