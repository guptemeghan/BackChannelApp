require 'spec_helper'

describe "replies/show" do
  before(:each) do
    @reply = assign(:reply, stub_model(Reply,
      :replydescription => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
