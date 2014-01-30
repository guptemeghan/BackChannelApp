require 'spec_helper'

describe "replies/new" do
  before(:each) do
    assign(:reply, stub_model(Reply,
      :replydescription => "MyText"
    ).as_new_record)
  end

  it "renders new reply form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", replies_path, "post" do
    #assert_select "textarea#reply_replydescription[name=?]", "reply[replydescription]"
    end
  end
  end

