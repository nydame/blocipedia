class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.present? && ! ( user.standard? && wiki.private )
  end

  def create?
    user.present?
  end

  def update?
    user.present?  && user == wiki.user
  end

  def destroy?
    user.present? && (user == wiki.user || user.admin?)

  end

  protected

  def wiki
    record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
