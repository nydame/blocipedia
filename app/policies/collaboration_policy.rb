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
    # current_user_is_cool && wiki_is_cool
    current_user_is_cool
  end

  def destroy?
    current_user_is_cool
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

  def current_user_is_cool
    # user has signed on
    # user is wiki owner or an admin
    wiki = collaboration.wiki
    wiki.user.present? || current_user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
