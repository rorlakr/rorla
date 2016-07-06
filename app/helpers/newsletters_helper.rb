module NewslettersHelper
  def preview_section( name, index )
    articles = @newsletter.articles.where( news_section_id: index )
    content_tag(:tr) do
      concat(content_tag(:th, name, class:'col-md-2 text-right hidden-xs'))
      concat(content_tag(:td, class: 'section_articles') do
        concat(content_tag(:div, name, class:'section_head_mobile visible-xs'))
        concat(content_tag(:div, id: "section_articles_#{index}") do
          concat render(articles)
        end)
      end)
    end unless articles.size.zero?
  end

  def preview_sections
    content_tag(:table, class:'table table-striped') do
      %w(행사안내 읽을꺼리 볼꺼리 신간소개 채용공고 업체홍보).each_with_index do | section, index |
        concat preview_section( section, index + 1  )
      end
    end
  end

  def show_section( name, index, options={} )
    articles = @newsletter.articles.where( news_section_id: index )
    content_tag(:tr) do
      concat(content_tag(:th, name, class: "text-right hidden-xs"))
      concat(content_tag(:td, class: 'section_articles') do
        concat(content_tag(:div, name, class:'section_head_mobile visible-xs'))
        concat(content_tag(:div, id: "section_articles_#{index}") do
          concat render(articles)
          if options[:edit] && user_signed_in? && current_user.can_create?(Article)
            concat(content_tag(:div, class:'add_article') do
              link_to("추가", new_newsletter_article_path(@newsletter, news_section_id: index), id: "add_article_link_#{index}", class: 'add_article_link btn btn-default btn-xs pull-right', remote: true)
            end)
          end
        end)
      end)
    end
  end

  def show_sections()
    capture do
      %w(행사안내 읽을꺼리 볼꺼리 신간소개 채용공고 업체홍보).each_with_index do | section, index |
        concat show_section( section, index + 1, edit: true )
      end
    end
  end

end
