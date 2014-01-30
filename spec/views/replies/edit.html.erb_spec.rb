require 'spec_helper'

describe "replies/edit" do
  before(:each) do
    @reply = assign(:reply, stub_model(Reply,
      :replydescription => "MyText"
    ))
  end

  it "renders the edit reply form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "form[action=?][method=?]", reply_path(@reply), "post" do
    #assert_select "textarea#reply_replydescription[name=?]", "reply[replydescription]"
    end
  end

