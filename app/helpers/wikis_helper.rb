module WikisHelper
  def name_of_wiki_owner(wiki)
    user = User.find(wiki.user_id)
    user.username
  end
end
