class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :primary_key => :user_id do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      # t.string :email, :null => false
      t.string :phone
      t.string :organization
      t.string :interests
      t.boolean :volunteer, :default => false
      t.boolean :donate, :default => false
      t.boolean :admin, :default => false, :null => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
