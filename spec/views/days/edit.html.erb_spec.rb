require 'rails_helper'

RSpec.describe "days/edit", type: :view do
  before(:each) do
    @day = assign(:day, Day.create!(
      :bleeding => 1,
      :sensation => "MyString",
      :characteristics => "MyString",
      :cervix => "MyString",
      :temp => 1
    ))
  end

  it "renders the edit day form" do
    render

    assert_select "form[action=?][method=?]", day_path(@day), "post" do

      assert_select "input#day_bleeding[name=?]", "day[bleeding]"

      assert_select "input#day_sensation[name=?]", "day[sensation]"

      assert_select "input#day_characteristics[name=?]", "day[characteristics]"

      assert_select "input#day_cervix[name=?]", "day[cervix]"

      assert_select "input#day_temp[name=?]", "day[temp]"
    end
  end
end
