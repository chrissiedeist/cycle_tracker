class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :bleeding
      t.string :sensation
      t.string :characteristics
      t.string :cervix
      t.integer :temp

      t.timestamps null: false
    end
  end
end
