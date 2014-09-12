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

  def icon_tags(tags_array)
    label_tags = ""
    tags_array.each do |tag|
      label_tags += "<a href='/favlinks?tag=#{CGI::escape(tag)}'><span class='badge badge-default'>#{tag}</span></a> "
    end
    icon('tag') + " " + label_tags.html_safe unless tags_array.blank?
  end

  def icon_shared(shared)
    shared ? icon('share') : icon('lock')
  end

  def active_menu(*target_controller)
    target_controller.include?(controller_name) ? 'active' : ''
  end

  def user_email(post)
    post.user.present? ? post.user.email : "an anonymous user"
  end

  def user_roles(user)
    user.roles.map(&:name).join(', ').titleize
  end

  def pageless(total_pages, url=nil, container=nil)
    opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderMsg  => 'Loading more pages...',
        :loaderImage => asset_path('load1.gif')
    }

    container && opts[:container] ||= container

    javascript_tag("$('#{container}').pageless(#{opts.to_json});")
  end

  def authored_by(user)
    icon_label('user', t('authored_html', who: user.writer.email, ago: time_ago_in_words(user.created_at)))
  end
end
