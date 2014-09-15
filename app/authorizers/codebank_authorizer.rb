class CodebankAuthorizer < ApplicationAuthorizer

  def updatable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

end
