class User < ApplicationRecord
  before_save {self.email = email.downcase if email.present?}
  has_many :wikis, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :co_wikis, through: :collaborations, source: :wiki

  enum role: [:admin, :premium, :standard]
  after_initialize :get_defaults

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def my_wikis
    Wiki.where({user_id: self.id})
  end

  def their_wikis
    Wiki.where(["user_id != ?", self.id])
  end

  def is_collaborating_on?(wid)
    co_wikis.find_by(id: wid) != nil
  end

   protected

   def get_defaults
     self.role ||= :standard
   end

end
