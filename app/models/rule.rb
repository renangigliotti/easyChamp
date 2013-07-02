class Rule < ActiveRecord::Base
  attr_accessible :name
  has_many :championships
end
