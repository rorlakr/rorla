# MarkdownRails.configure do |config|
#   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
#     :fenced_code_blocks => true,
#     :autolink => true,
#     :prettify => true)
#   config.render do |markdown_source|
#     markdown.render(markdown_source)
#   end
# end

# create a custom renderer that allows highlighting of code blocks
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, lang)
    lang = lang && lang.split.first || "text"
    output = add_code_tags(
      Pygmentize.process(code, lang), lang
    )
  end

  def add_code_tags(code, lang)
    code = code.sub(/<pre>/,'<div class="lang">' + lang + '</div><pre><code class="' + lang + '">')
    code = code.sub(/<\/pre>/,"</code></pre>")
  end
end

MarkdownRails.configure do |config|
  markdown = Redcarpet::Markdown.new(HTMLwithPygments,:fenced_code_blocks => true,:autolink => true,:prettify => true)
  config.render do |markdown_source|
    markdown.render(markdown_source)
  end
end
