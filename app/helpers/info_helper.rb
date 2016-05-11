module InfoHelper

  def profile(group, title, user)
    content_tag(:div, class:'col-sm-4') do
      content_tag(:a, class:"contributor", 'data-toggle':"popover", 'data-html':"true", 'data-placement':'auto', 'data-trigger':"hover", title: "#{user.user_profile.name}<br />#{user.email}", 'data-content': "#{user.user_profile.intro || '자기소개'}<br />Github: #{user.user_profile.github || 'github계정'}<br />직장: #{user.user_profile.company || 직장명} (#{user.user_profile.title || '직함'})<br />블로그: #{user.user_profile.blog}<br />웹사이트: #{user.user_profile.website}") do
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

end
