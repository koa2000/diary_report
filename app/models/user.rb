class User < ActiveRecord::Base
  attr_accessible :email
  def self.authenticate(email)
    where(:email => email).first
   end
end
