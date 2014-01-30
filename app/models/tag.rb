class Tag < ActiveRecord::Base
  attr_accessible :tagname

  belongs_to :post
  validates :tagname, :presence => true
end
