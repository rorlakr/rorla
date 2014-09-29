module InfoHelper

  def profile(group, title, name)
    content_tag(:div, class:'col-sm-4') do
      content_tag(:div, class:"panel panel-#{group}") do
        concat(content_tag(:div, class:'panel-heading') do
          concat content_tag(:h3, title, class:'panel-title')
          concat(content_tag(:div, class:'panel-body') do
            concat image_tag("contributors/generic-user.png", class:'profile')
            concat " "
            concat name
          end)
        end)
      end
    end
  end

end
