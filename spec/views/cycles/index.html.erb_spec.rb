require 'rails_helper'

RSpec.describe "cycles/index", type: :view do
  before(:each) do
    assign(:cycles, [
      Cycle.create!(),
      Cycle.create!()
    ])
  end

  it "renders a list of cycles" do
    render
  end
end
