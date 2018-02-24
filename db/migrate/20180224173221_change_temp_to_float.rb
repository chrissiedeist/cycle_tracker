class ChangeTempToFloat < ActiveRecord::Migration
  def change
     change_column :days, :temp, :float
  end
end
