class CollaborationPolicy < ApplicationPolicy

  # def new?
  #   user.present?
  # end

  def create?
    #user is present
    #wiki exists
    #user is owner of wiki associated with this record
    #wiki is private
    #collaboration does not already exist
    # user_is_cool && wiki_is_cool && ! collaboration_is_redundant
    user_is_cool
  end

  def destroy?
    user_is_cool
  end

  protected

  def collaboration
    record
  end

  def wiki
    collaboration.wiki
  end

  def wiki_is_cool
    # wiki exists
    # wiki is private
    wiki != nil && wiki.private
  end

  def user_is_cool
    # user has signed on
    # user is wiki owner or an admin
    wiki = collaboration.wiki
    user = wiki.user
    user.present? || user.admin?
  end

  def collaboration_is_redundant
    Collaboration.where({user_id: collaboration.user_id, wiki_id: collaboration.wiki_id}).count > 0
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
