class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  validates :wiki, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :wiki_id
end
