module InfoHelper

  def profile(group, title, image, name)
    %{
      <div class="col-sm-4"><div class="panel panel-#{group}">
        <div class="panel-heading"><h3 class="panel-title">#{title}</h3></div>
        <div class="panel-body">#{ image_tag("contributors/#{image}", class:'profile') } #{name}</div>
      </div></div>
    }.html_safe
  end
end

