class Event < ActiveRecord::Base
  require 'time'
  require 'date'

  attr_accessible :event_id, :name, :desc, :from_date, :to_date, :from_time, :to_time, :venue, :category, :category_id, :min_before_start, :max_before_end, :created_by, :updated_by, :deleted
  
  # an event must have a category
  belongs_to :category
  
  # associate event with user through user_event table
  has_many :user_events
  has_many :users, through: :user_events
  
  # use event_id as the primary key and not the default generated id column
  self.primary_key = "event_id"
  
  # the username, password fields must be present
  validates :name, :from_date, :to_date, :from_time, :to_time, presence: true
  
  # user cannot sign-in to the event before 30mins of the start
  validates :min_before_start, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 90 }
  
  # user can sign-in till 30mins before end
  validates :max_before_end, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 90 }
  
  # all date validations
  validate :from_date_cannot_be_in_the_past, :to_date_cannot_be_in_the_past, :to_date_cannot_be_less_than_from_date, :to_time_cannot_be_less_than_from_time
 
  # Registering ActiveRecord Callbacks
  before_create do
	recalculcate_from_time_and_to_time()
  end

  before_update do
    recalculcate_from_time_and_to_time()
  end
  
  def recalculcate_from_time_and_to_time
  	# from_time should be added to from_date, to_time should be added to to_date
    
	if from_date.present?
		self.from_time = Time.mktime(from_date.year, from_date.month, from_date.day, self.from_time.hour, self.from_time.min)
	end
	
	if to_date.present?
		self.to_time = Time.mktime(to_date.year, to_date.month, to_date.day, self.to_time.hour, self.to_time.min)
	end
  end
  
  def from_date_cannot_be_in_the_past
    if from_date.present? && from_date < Date.today
      errors.add(:from_date, "can't be in the past")
    end
  end

  def to_date_cannot_be_in_the_past
    if to_date.present? && to_date < Date.today
      errors.add(:to_date, "can't be in the past")
    end
  end
  
  def to_date_cannot_be_less_than_from_date
    if to_date.present? && to_date < from_date
      errors.add(:to_date, "can't be less than From Date")
    end
  end
  
  def to_time_cannot_be_less_than_from_time
    if to_time.present? && to_time < from_time
      errors.add(:to_time, "can't be less than From Time")
    end
  end

end
