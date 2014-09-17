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
    "#{icon(shape)} #{label}".html_safe
    # "<span class='glyphicon glyphicon-#{shape}'></span> #{label}".html_safe
  end

  def icon_button(shape)
    "<span class='label label-default'>#{icon(shape)}</span>".html_safe
    # "<span class='label label-default'><span class='glyphicon glyphicon-#{shape}'></span></span>".html_safe
  end

  def icon_label_button(shape, label)
    "#{icon_button(shape)} #{label}".html_safe
    # "<span class='label label-default'><span class='glyphicon glyphicon-#{shape}'></span></span> #{label}".html_safe
  end

  def awesome_icon(shape)
    "<span class='fa fa-#{shape}'></span>".html_safe
  end

  def awesome_icon_label(shape, label)
    "#{awesome_icon(shape)} #{label}".html_safe
    # "<span class='fa fa-#{shape}'></span> #{label}".html_safe
  end

  def awesome_icon_button(shape)
    "<span class='label label-default'>#{awesome_icon(shape)}</span>".html_safe
    # "<span class='label label-default'><span class='fa fa-#{shape}'></span></span>".html_safe
  end

  def awesome_icon_label_button(shape, label)
    "#{awesome_icon_button(shape)} #{label}".html_safe
    # "<span class='label label-default'><span class='fa fa-#{shape}'></span></span> #{label}".html_safe
  end

  def awesome_icon_shared(shared)
    shared ? awesome_icon('share-alt-square') : icon('lock')
  end

  def awesome_icon_shared_label(shared, label)
    (shared ? awesome_icon('share-alt-square') : icon('lock')) + ' ' + label
  end

  def ib_link_to(name, label, url, html_options = {})
    link_to(icon_label(name, label), url, html_options)
  end

  def awesome_ib_link_to(name, label, url, html_options = {})
    link_to(awesome_icon_label(name, label), url, html_options)
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
    post.user.present? ? post.user.account_name : "an anonymous user"
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

  def authored_by(user, date)
    icon_label('user', t('authored_html', who: user.account_name, ago: time_ago_in_words(date)))
  end
end
