class Admin < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable
  attr_accessible :email, :encrypted_password
end
