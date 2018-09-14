class CollaborationPolicy < ApplicationPolicy

  def create?
    current_user_is_cool
  end

  def destroy?
    current_user_is_cool
  end

  protected

  def collaboration
    record
  end

  def current_user_is_cool
    # user has signed on AND
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
