module InfoHelper
  def profile(group, title, user)
    content_tag(:div, class: 'col-sm-4 mb-2', style: 'height: 250px;') do
      content_tag(:div, class: 'flip-container', ontouchstart: "this.classList.toggle('hover');") do
        content_tag(:div, class: 'flipper') do
          concat(content_tag(:div, class: 'front') do
            content_tag(:div, class: "card bg-#{group}") do
              concat(
                content_tag(:div, class: 'card-header') do
                  content_tag(:div, title, class: 'text-center text-light')
                end
              )
              concat(
                content_tag(:div, class:'text-center card-body bg-light') do
                  if user.user_profile.nil?
                    image_tag('contributors/generic-user.png', class:'profile')
                  else
                    image_tag(user.user_profile.avatar_url(:thumb), class:'profile')
                  end
                end
              )
              concat(
                content_tag(:div, title: user.email, class:'text-center card-footer bg-light') do
                  contributor(user)
                end
              )
            end
          end)
          concat(content_tag(:div, class: 'back') do
            content_tag(:div, class: 'table-responsive-sm') do
              content_tag(:table, class: 'table table-sm m-0') do
                content_tag(:tbody) do
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '이름', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.name, class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '이메일', class: 'col-3'))
                    concat(content_tag(:td, user.email, class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '자기소개', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.intro || 'n/a', class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '깃헙계정', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.github || 'n/a', class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '직장', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.company || 'n/a', class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '직함', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.title || 'n/a', class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '블로그', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.blog || 'n/a', class: 'col-9'))
                  end)
                  concat(content_tag(:tr, class: 'd-flex') do
                    concat(content_tag(:th, '웹사이트', class: 'col-3'))
                    concat(content_tag(:td, user.user_profile.website || 'n/a', class: 'col-9'))
                  end)
                end
              end
            end
          end)
        end
      end
    end
  end
end


