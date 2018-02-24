class AddDbConstraints < ActiveRecord::Migration
  def change
    change_column_null :days, :date, false
    change_column_null :days, :number, false
  end
end
