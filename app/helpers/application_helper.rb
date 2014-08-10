module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  def icon(shape)
    "<span class='glyphicon glyphicon-#{shape}'></span>".html_safe
  end

  def icon_label(shape, label)
    "<span class='glyphicon glyphicon-#{shape}'></span> #{label}".html_safe
  end

  def icon_button(shape)
    "<span class='label label-default'><span class='glyphicon glyphicon-#{shape}'></span></span>".html_safe
  end

  def icon_lable_button(shape, label)
    "<span class='label label-default'><span class='glyphicon glyphicon-#{shape}'></span></span> #{label}".html_safe
  end

  def active_menu(target_controller)
    "class=#{controller_name == target_controller ? 'active' : ''}"
  end

  def user_email(post)
    post.user.present? ? post.user.email : "an anonymous user"
  end

  def user_roles(user)
    user.roles.map(&:name).join(', ').titleize
  end
end
