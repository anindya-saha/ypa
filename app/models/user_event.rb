class UserEvent < ActiveRecord::Base
  attr_accessible :user_id, :event_id, :rsvp, :signin, :created_by, :updated_by, :deleted
  belongs_to :user
  belongs_to :event
end
