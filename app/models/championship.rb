class Championship < ActiveRecord::Base
  attr_accessible :classification, :groups, :name, :rule_id
  belongs_to :rule
end
