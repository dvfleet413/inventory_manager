class Employee < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  belongs_to :company
  has_many :products, :through => :company
  has_one :admin, :through => :company

  def admin?
    false
  end

end
