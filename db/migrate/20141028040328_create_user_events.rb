class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.integer :user_id, :null => false
      t.integer :event_id, :null => false
      t.boolean :rsvp, :default => false, :null => false
      t.boolean :signin, :default => false, :null => false
      t.string :created_by
      t.string :updated_by
      t.boolean :deleted, :default => false, :null => false
      t.timestamps
    end
  end
end
