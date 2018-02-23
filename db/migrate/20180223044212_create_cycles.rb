class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.date :start_date

      t.timestamps null: false
    end
  end
end
