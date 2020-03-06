class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  belongs_to :company
  has_many :producs, :through => :company
  has_one :admin, :through => :company

  def admin?
    false
  end

end
