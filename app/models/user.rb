# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

class User < ActiveRecord::Base
  #create a password attribute that you can access
  attr_accessor	  :password
  
  #security to only allow users to change name and email (other db columns not user acccesable)
  attr_accessible :name, :email, :password, :password_confirmation


  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #\A and \z test for beginning and end of string

  #ensures that name and email are non-empty, and name is not longer than 50
  validates :name, 
	    :presence	=> true,
	    :length	=> {:maximum => 50}
  validates :email, 
	    :presence	=> true,
	    :format	=> {:with => email_regex},
	    :uniqueness => {:case_sensitive => false}

  validates :password,
	    :presence	    => true,
	    :confirmation   => true,
	    :length	    => {:within => 6..40}

end

