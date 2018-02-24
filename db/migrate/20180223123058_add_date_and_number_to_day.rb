class AddDateAndNumberToDay < ActiveRecord::Migration
  def change
    add_column :days, :date, :date, required: true
    add_column :days, :number, :integer, required: true
  end

end
