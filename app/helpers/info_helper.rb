module InfoHelper

  def profile(group, title, user)
    content_tag(:div, class:'col-sm-4') do
      content_tag(:div, class:"panel panel-#{group}") do
        concat(
          content_tag(:div, class:'panel-heading') do
            content_tag(:div, title, class:'text-center')
          end
        )
        concat(
          content_tag(:div, class:'text-center panel-body') do
            if user.user_profile.nil?
              image_tag('contributors/generic-user.png', class:'profile')
            else
              image_tag(user.user_profile.avatar_url(:thumb), class:'profile')
            end
          end
        )
        concat(
          content_tag(:div, title: user.email, class:'text-center panel-footer') do
            contributor(user)
          end
        )
      end
    end
  end

end
