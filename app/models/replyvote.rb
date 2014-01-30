class Replyvote < ActiveRecord::Base
  attr_accessible :studentid

  belongs_to :reply
  validates :studentid, :presence => true
end
