require 'rails_helper'

RSpec.describe "days/show", type: :view do
  before(:each) do
    @day = assign(:day, Day.create!(
      :bleeding => 2,
      :sensation => "Sensation",
      :characteristics => "Characteristics",
      :cervix => "Cervix",
      :temp => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Sensation/)
    expect(rendered).to match(/Characteristics/)
    expect(rendered).to match(/Cervix/)
    expect(rendered).to match(/3/)
  end
end
