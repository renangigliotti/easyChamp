class Team < ActiveRecord::Base
  attr_accessible :abbreviation, :logo, :name

  belongs_to :championship
end
