class PrivateValidator < ActiveModel::Validator
  def validate(record)
    unless record.wiki.private
      record.errors[:wiki_id] << 'Collaboration is permitted on private Wikis only.'
    end
  end
end

class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  validates :wiki, private: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :wiki_id

  protected

  def wiki_is_private?
    Wiki.where(id: self.wiki_id).pluck(:private)[0]
  end
end
