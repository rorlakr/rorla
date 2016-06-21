module ApplicationHelper

  # Always use the Twitter Bootstrap pagination renderer
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => BootstrapPagination::Rails
    end
    super *[collection_or_options, options].compact
  end

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
    content_tag(:span, '', class: "glyphicon glyphicon-#{shape}")
  end

  def icon_label(shape, label)
    content_tag(:span, '', class: "glyphicon glyphicon-#{shape}") + ' ' + label
  end

  def icon_button(shape, kind='default')
    content_tag(:span, icon(shape), class: "label label-#{kind}")
  end

  def icon_label_button(shape, label, kind='default')
    content_tag(:span, icon(shape, label), class: "label label-#{kind}")
  end

  def awesome_icon(shape, size="1x")
    content_tag(:span, '', class: "fa fa-#{shape} fa-#{size}")
  end

  def awesome_icon_label(shape, label)
    content_tag(:span, '', class: "fa fa-#{shape}") + ' ' + label
  end

  def awesome_icon_button(shape, kind='default')
    content_tag(:span, awesome_icon(shape), class: "label label-#{kind}")
  end

  def awesome_icon_label_button(shape, label, kind='default')
    content_tag(:span, awesome_icon_label(shape, label), class: "label label-#{kind}")
  end

  def awesome_icon_shared(shared)
    shared ? awesome_icon('share-alt-square') : icon('lock')
  end

  def awesome_icon_shared_label(shared, label)
    capture do
      concat(shared ? awesome_icon('share-alt-square') : icon('lock'))
      concat ' '
      concat label
    end
  end

  def ib_link_to(name, label, url, html_options = {})
    link_to(icon_label(name, label), url, html_options)
  end

  def awesome_ib_link_to(name, label, url, html_options = {})
    link_to(awesome_icon_label(name, label), url, html_options)
  end

  def icon_tags(tags_array, resource)
    label_tags = ""
    tags_array.each do |tag|
      label_tags += "<a href='/#{resource}?tag=#{CGI::escape(tag)}'><span class='badge badge-default'>#{tag}</span></a> "
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

  def yield_content!(content_key)
    view_flow.content.delete(content_key)
  end

  def alert_box(kind, message)
    content_tag :div, role: "alert", class: "alert alert-#{kind} alert-dismissible" do
      content_tag :button, type: 'button', class: 'close', data: {dismiss: 'alert'} do
        content_tag(:span, raw('&times;'), 'aria-hidden' => 'true') +
        content_tag(:span, 'Close', class:'sr-only')
      end.concat message
    end
  end

  def alert_box1(kind="warning", title="Warning!", message="Warnings occurred")
    content_tag(:div, class:"alert alert-#{kind} alert-dismissible", role: "alert") do
      concat(content_tag(:button, type: 'button', class: 'close', data: {dismiss: 'alert'}) do
        concat content_tag(:span, raw('&times;'), "aria-hidden"=>"true")
        concat content_tag(:span, "Close", class:"sr-only")
      end)
      concat content_tag(:strong, title)
      concat " "
      concat message
    end
  end

  def alert_box_multiple(kind, title, messages)
    content_tag :div, role: "alert", class: "alert alert-#{kind} alert-dismissible" do
      concat(content_tag(:button, type: 'button', class: 'close', data: {dismiss: 'alert'}) do
        content_tag(:span, raw('&times;'), 'aria-hidden' => 'true') +
        content_tag(:span, 'Close', class:'sr-only')
      end)
      concat(content_tag(:h4, title))
      concat(content_tag(:ul) do
        messages.map do |field, messages|
          messages.map do |message|
            content_tag :li, t("activerecord.attributes.question.#{field}") + message
          end.join('').html_safe
        end.join('').html_safe
      end)
    end
  end

  def account_with_tooltip(email)
    content_tag :span, title: email, data:{toggle:'tooltip'} do
      content_tag(:i, content_tag(:strong, email.split('@').first.capitalize)).html_safe
    end
  end

  def copyright_with_tooltip(resource, email)
    capture do
      concat content_tag(:small, icon('user'))
      concat ' '
      concat t('authored_html', who: account_with_tooltip(email), ago: time_ago_in_words(resource.created_at))
    end
  end

  def hit_count(count)
    content_tag(:small, '', title:'뷰갯수', class:'text-muted', data:{toggle:'tooltip'}) do
      awesome_icon_label('bullseye', content_tag(:i, " #{count}", style:'font-weight:bold;'))
    end
  end

  def comment_count(count)
    content_tag(:small, '', title:'댓글갯수', class:'text-muted', data:{toggle:'tooltip'}) do
      icon_label('comment', content_tag(:i, " #{count}", style:'font-weight:bold;'))
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-info btn-xs", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<div class="embed-responsive embed-responsive-4by3"><iframe class="embed-responsive-item" title="YouTube video player" width="100%" height="auto" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe></div>}
  end

  def contributor(user)
    user.user_profile.nil? ? user.email : (user.user_profile.name.nil? ? user.email : user.user_profile.name)
  end

  def yesno(bool)
    bool ? "예" : "아니오"
  end
end
