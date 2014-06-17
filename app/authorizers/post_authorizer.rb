class PostAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user, options={})
    if ["공지사항", "새소식"].include? options[:for].title
      user.has_role?(:admin)
    else
      user.has_role?(:user) || user.has_role?(:admin)
    end
  end

  def updatable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.writer == user || user.has_role?(:admin)
  end

end
