class Reply < ActiveRecord::Base
  attr_accessible :replydescription , :post_id

  belongs_to :post
  has_many :replyvotes
  validates :replydescription, :presence => true
end
