class Admin < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  belongs_to :company
  has_many :products, :through => :company
  has_many :employees, :through => :company

  def admin?
    true
  end
end
