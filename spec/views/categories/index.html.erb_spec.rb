require 'spec_helper'

describe "categories/index" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :categoryname => "Categoryname"
      ),
      stub_model(Category,
        :categoryname => "Categoryname"
      )
    ])
  end

  it "renders a list of categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Categoryname".to_s, :count => 2
  end
end
