class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user

  def has_collaborators?
    collaborators.count > 0
  end

  def has_collaborator?(someones_id)
    collaborators.find_by(id: someones_id) != nil
  end
  # example of SQL query
  # Wiki Load (0.3ms)  SELECT  "wikis".* FROM "wikis" WHERE "wikis"."private" = ? ORDER BY "wikis"."id" ASC LIMIT ?  [["private", 1], ["LIMIT", 1]]
  # User Load (1.0ms)  SELECT  "users".* FROM "users" INNER JOIN "collaborations" ON "users"."id" = "collaborations"."user_id" WHERE "collaborations"."wiki_id" = ? AND "users"."id" = ? LIMIT ?  [["wiki_id", 8], ["id", 1], ["LIMIT", 1]]

end
