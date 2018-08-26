class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    # user.present? && (user == wiki.user || user.admin?)
    user.present?
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