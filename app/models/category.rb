class Category < ActiveRecord::Base
  attr_accessible :category_id, :name, :desc, :created_by, :updated_by, :deleted
  has_many :events
end
