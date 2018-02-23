require 'rails_helper'

RSpec.describe "days/index", type: :view do
  before(:each) do
    assign(:days, [
      Day.create!(
        :bleeding => 2,
        :sensation => "Sensation",
        :characteristics => "Characteristics",
        :cervix => "Cervix",
        :temp => 3
      ),
      Day.create!(
        :bleeding => 2,
        :sensation => "Sensation",
        :characteristics => "Characteristics",
        :cervix => "Cervix",
        :temp => 3
      )
    ])
  end

  it "renders a list of days" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Sensation".to_s, :count => 2
    assert_select "tr>td", :text => "Characteristics".to_s, :count => 2
    assert_select "tr>td", :text => "Cervix".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
