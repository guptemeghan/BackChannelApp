require 'spec_helper'

describe User do
  it "There are no users in database" do
    expect(User).to have(:no).records
    expect(User).to have(0).records
  end

  it "counts only Users that match a query" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    expect(User.where(:name => "Prathmesh")).to have(1).record
    expect(User.where(:name => "Meghan")).to have(0).records
  end

  it "Create User" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    expect(User.count).to eq(1)
  end

  it "Validating Creating User with Duplicate Username" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2).errors_on(:username)).to include("has already been taken")
  end

  it "Validating Creating User with Duplicate student id" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2).errors_on(:studentid)).to include("has already been taken")
  end

  it "Validating Creating User with Duplicate student id" do
    user = User.create!(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2)
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2).errors_on(:email)).to include("has already been taken")
  end

  it "Validating Creating User without name" do
    expect(User.new(name: "", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2).errors_on(:name)).to include("can't be blank")
  end

  it "Validating Creating User without username" do
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"",password:"pkadam",priority:2).errors_on(:username)).to include("can't be blank")
  end

  it "Validating Creating User without email" do
    expect(User.new(name: "Prathmesh", email: "",studentid: "200020986", username:"pkadam",password:"pkadam",priority:2).errors_on(:email)).to include("can't be blank")
  end

  it "Validating Creating User without studentid" do
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "", username:"pkadam",password:"pkadam",priority:2).errors_on(:studentid)).to include("can't be blank")
  end

  it "Validating Creating User without password" do
    expect(User.new(name: "Prathmesh", email: "pkadam@ncsu.edu",studentid: "200020986", username:"pkadam",password:"",priority:2).errors_on(:password)).to include("can't be blank")
  end



end

