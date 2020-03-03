class Admin < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  belongs_to :company
  has_many :producs, :through => :company
  has_many :users, :through => :company
end
