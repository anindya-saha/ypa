class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, :primary_key => :event_id do |t|
      t.string :name, :null => false
      t.text :desc
      t.date :from_date, :null => false
      t.date :to_date, :null => false
      t.time :from_time
      t.time :to_time
      t.string :venue
      t.belongs_to :category
      t.integer :min_before_start
      t.integer :max_before_end
      t.string :created_by
      t.string :updated_by
      t.boolean :deleted, :default => false, :null => false

      t.timestamps
    end
  end
end
