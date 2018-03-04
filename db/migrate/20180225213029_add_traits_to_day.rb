class AddTraitsToDay < ActiveRecord::Migration
  def change
    add_column :days, :weight, :integer
    add_column :days, :cramps, :integer
    add_column :days, :irritability, :integer
    add_column :days, :sensitivity, :integer
    add_column :days, :drinks, :integer
    add_column :days, :hours_sleep, :integer
  end
end
