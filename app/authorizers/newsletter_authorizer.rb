class NewsletterAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user, options={})
    user.has_role?(:contributor) || user.has_role?(:admin)
  end

  def updatable_by?(user)
    resource.editor == user || user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.editor == user || user.has_role?(:admin)
  end

end
