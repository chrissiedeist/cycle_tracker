require 'rails_helper'

RSpec.describe "days/new", type: :view do
  before(:each) do
    assign(:day, Day.new(
      :bleeding => 1,
      :sensation => "MyString",
      :characteristics => "MyString",
      :cervix => "MyString",
      :temp => 1
    ))
  end

  it "renders new day form" do
    render

    assert_select "form[action=?][method=?]", days_path, "post" do

      assert_select "input#day_bleeding[name=?]", "day[bleeding]"

      assert_select "input#day_sensation[name=?]", "day[sensation]"

      assert_select "input#day_characteristics[name=?]", "day[characteristics]"

      assert_select "input#day_cervix[name=?]", "day[cervix]"

      assert_select "input#day_temp[name=?]", "day[temp]"
    end
  end
end
