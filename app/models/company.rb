class Company < ActiveRecord::Base
  has_many :products
  has_one :admin
  has_many :users

end
