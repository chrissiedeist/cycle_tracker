class AddDaysToCycle < ActiveRecord::Migration
  def change
    add_reference :days, :cycle, index: true
  end
end
