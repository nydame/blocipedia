module WikisHelper
  def name_of_wiki_owner(wiki)
    user = User.find(wiki.user_id)
    user.username
  end

  def render_markdown_as_html(wiki_body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, disable_indented_code_blocks: true, superscript: true)
    markdown.render(wiki_body)
  end
end
