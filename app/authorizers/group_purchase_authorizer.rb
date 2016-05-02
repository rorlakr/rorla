class GroupPurchaseAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.has_role?(:admin)
  end

  def updatable_by?(user)
    user.has_role?(:admin)
  end

  def deletable_by?(user)
    user.has_role?(:admin)
  end

end
