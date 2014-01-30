class Category < ActiveRecord::Base
  attr_accessible :categoryname
  has_many :posts
  validates :categoryname, :presence => true
end
