class User < ApplicationRecord
  before_save {self.email = email.downcase if email.present?}
  has_many :wikis, dependent: :destroy

  enum role: [:admin, :premium, :standard]
  after_initialize :get_defaults

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

   protected
   
   def get_defaults
     self.role ||= :standard
   end

end
