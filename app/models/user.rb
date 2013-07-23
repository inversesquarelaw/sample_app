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

  before_save :encrypt_password

  def has_password?(submitted_password)
    #don't need "self." here because just a comparison
    encrypted_password == encrypt(submitted_password)
  end


  #def User.authenticate == self.authenticate
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    (user && user.has_password?(submitted_password)) ? user : nil
    #the about ternary line replaces the next 2 return likes
    #return nil	if user.nil?
    #return user	if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      #need "self." here b/c it will create a local variable if we don't.
      #we want to assign to this objects encrypted_password not create a new one
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{self.salt}--#{string}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

end

