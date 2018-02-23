require 'rails_helper'

RSpec.describe "cycles/new", type: :view do
  before(:each) do
    assign(:cycle, Cycle.new())
  end

  it "renders new cycle form" do
    render

    assert_select "form[action=?][method=?]", cycles_path, "post" do
    end
  end
end
