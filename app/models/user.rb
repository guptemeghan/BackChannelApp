class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :priority, :username , :studentid

  has_many :posts

  validates :email, :presence => true, :uniqueness =>true
  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness =>true
  validates :password, :presence => true
  validates :studentid, :presence => true, :uniqueness =>true
end
