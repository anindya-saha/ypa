class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :user_id, :first_name, :last_name, :password, :password_confirmation, :encrypted_password, :remember_me, :dob, :email, :phone, :organization, :donate, :volunteer, :interests, :admin, :created_by, :updated_by, :deleted

  # we want to use user_id as the primary key and not the default generated id
  self.primary_key = "user_id"

  # the username, password fields must be present
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME = /\w/i

  #validates :password, presence: true
  #above already taken care of by device.  including this is causes problems on the My Account page (forces user to change password)
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :phone, format: {with: /\d/ }

  # associate user with event through user_event table
  has_many :user_events
  has_many :events, through: :user_events

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
