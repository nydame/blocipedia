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
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      all_wikis = scope.all
      if user.role == "admin"
        wikis = all_wikis
      elsif user.role == "premium"
        all_wikis.each do |wiki|
          if ! wiki.private || wiki.user = user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis.each do |wiki|
          if ! wiki.private || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end # endif
      wikis
    end # end resolve

  end # end class Scope

end
