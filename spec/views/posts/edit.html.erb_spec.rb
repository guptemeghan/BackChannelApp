require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :studentid => "MyString",
      :postdescription => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
      #assert_select "input#post_studentid[name=?]", "post[studentid]"
      #assert_select "textarea#post_postdescription[name=?]", "post[postdescription]"
    end
  end
end
