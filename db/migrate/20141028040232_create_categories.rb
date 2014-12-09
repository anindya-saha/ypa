class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
	  t.string :name
      t.text :desc
      t.string :created_by
      t.string :updated_by
      t.boolean :deleted

      t.timestamps
    end
  end
end
