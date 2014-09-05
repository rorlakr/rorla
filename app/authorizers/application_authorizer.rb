# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  def self.default(adjective, user)
    user.has_role? :admin
  end

  def updatable_by?(user)
    resource.user == user || has_role?(:admin)
  end

  def deletable_by(user)
    resource.user == user || has_role?(:admin)
  end

end
