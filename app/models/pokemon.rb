class Pokemon < ActiveRecord::Base

  has_many :move
  belongs_to :user

end
