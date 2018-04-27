class AddTendernessAgainToDays < ActiveRecord::Migration
  def change
    add_column :days, :tenderness, :string
  end
end
