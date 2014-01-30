class Postvote < ActiveRecord::Base
  attr_accessible :studentid

  belongs_to :post
  validates :studentid, :presence => true
end
