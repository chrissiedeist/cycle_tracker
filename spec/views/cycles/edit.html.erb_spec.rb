require 'rails_helper'

RSpec.describe "cycles/edit", type: :view do
  before(:each) do
    @cycle = assign(:cycle, Cycle.create!())
  end

  it "renders the edit cycle form" do
    render

    assert_select "form[action=?][method=?]", cycle_path(@cycle), "post" do
    end
  end
end
