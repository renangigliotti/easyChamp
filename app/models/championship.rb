class Championship < ActiveRecord::Base
  attr_accessible :name, :rule_id, :date_start
  belongs_to :rule
end
