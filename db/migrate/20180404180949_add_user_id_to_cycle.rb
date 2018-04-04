class AddUserIdToCycle < ActiveRecord::Migration
  def change
    add_reference :cycles, :user, index: true
  end
end
