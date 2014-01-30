class Post < ActiveRecord::Base
  attr_accessible :postdescription, :studentid,:category_id,:title

  belongs_to :user
  belongs_to :category
  has_many :replies
  has_many :tags
  has_many :postvotes

  validates :studentid, :presence => true
  validates :category_id, :presence => true
  validates :postdescription, :presence => true
  validates :title, :presence => true
end
