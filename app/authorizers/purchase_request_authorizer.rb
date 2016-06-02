class PurchaseRequestAuthorizer < ApplicationAuthorizer

  def readable_by?(user)
    resource.user == user || user.has_role?(:admin)
  end

  def self.creatable_by?(user, options={})
    # g = GroupPurchase.find(options[:for].id)
    # g.purchase_requests.where(user: user).size == 0
    user.has_role?(:user) || user.has_role?(:admin)
  end

  def updatable_by?(user)
    (resource.user == user && !resource.confirmed ) || user.has_role?(:admin)
  end

  def deletable_by?(user)
    (resource.user == user && !resource.confirmed ) || user.has_role?(:admin)
  end

  def confirmable_by(user)
    user.has_role?(:admin)
  end

end
