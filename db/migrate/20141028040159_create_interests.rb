class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.text :description
      t.string :created_by
      t.string :updated_by
      t.boolean :deleted

      t.timestamps
    end
  end
end
