module NewslettersHelper
  def preview_section( name, index )
    articles = @newsletter.articles.where( news_section_id: index)
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
end
