require 'spec_helper'

describe Post do
  it "There are no posts in database" do
    expect(Post).to have(:no).records
    expect(Post).to have(0).records
  end

  it "Successfully creating a post" do
    post1 = Post.new(studentid: "200020986", postdescription: "Post 1", title: "Title 1" )
    post1.user_id  = 1;
    post1.category_id = 1
    post1.save!

    expect(Post.all).to have(1).records
  end

  it "counts only Posts for a particular student" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    category = Category.create!(categoryname: "OOLS")
    post1 = Post.new(studentid: "200020986", postdescription: "Post 1", title: "Title 1" )
    post1.user_id  = 1;
    post1.category_id = 1
    post1.save!
    post2 = Post.new(studentid: "200020986", postdescription: "Post 2", title: "Title 2")
    post2.user_id  = 1;
    post2.category_id = 1
    post2.save!
    expect(Post.where(:studentid => "200020986")).to have(2).records
  end

  it "Validating Creating Post without Title" do
    expect(Post.new(studentid: "200020986", postdescription: "Post 1", title: "" ).errors_on(:title)).to include("can't be blank")
  end

  it "Validating Creating Post without Post Description" do
    expect(Post.new(studentid: "200020986", postdescription: "", title: "Title 1" ).errors_on(:postdescription)).to include("can't be blank")
  end

end
