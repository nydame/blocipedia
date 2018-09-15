module WikisHelper
  def name_of_wiki_owner(wiki)
    user = User.find(wiki.user_id)
    user.username
  end

  def candidate_list(wiki)
    #return an array using pluck()
    # raw_result = User.joins(:collaborations).where.not({collaborations: {wiki_id: wiki.id}})
    # raw_result.where.not({id: wiki.user_id}).pluck(:id, :username)
    result = []
    User.all.each do |u|
      result.push([u.username, u.id]) unless u.is_collaborating_on?(wiki.id) || u.id == wiki.user.id
    end
    return result
  end

  def collaborator_list(wiki)
    #return an array using pluck()
    User.joins(:collaborations).where({collaborations: {wiki_id: wiki.id}}).pluck(:id, :username)
  end

  def collaboration_from_user(uid, wid)
    #return a number
    c = Collaboration.where(user_id: uid, wiki_id: wid).pluck(:id)
    return c[0] unless c.count < 1
  end

  def render_markdown_as_html(wiki_body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, disable_indented_code_blocks: true, superscript: true)
    markdown.render(wiki_body)
  end
end
