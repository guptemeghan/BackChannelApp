require 'spec_helper'

describe Reply do
  it "There are no posts in database" do
    expect(Reply).to have(:no).records
    expect(Reply).to have(0).records
  end

  it "Successfully creating a reply" do
    post1 = Reply.new( replydescription: "Reply 1" )
    post1.user_id  = 1;
    post1.post_id = 1
    post1.save!

    expect(Reply.all).to have(1).records
  end

  it "counts only Replies for a particular student" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    category = Category.create!(categoryname: "OOLS")
    reply1 = Reply.new(replydescription: "Reply 1")
    reply1.user_id  = 1;
    reply1.post_id = 1
    reply1.save!
    expect(Reply.where(:user_id => "1")).to have(1).records
  end

  it "Validating Creating Reply without reply description" do
    expect(Reply.new(replydescription: "" ).errors_on(:replydescription)).to include("can't be blank")
  end
end
