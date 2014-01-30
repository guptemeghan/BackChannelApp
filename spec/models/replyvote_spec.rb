require 'spec_helper'

describe Replyvote do
  it "There are no reply votes in database" do
    expect(Replyvote).to have(:no).records
    expect(Replyvote).to have(0).records
  end

  it "Creating two reply votes in database" do
    replyvote1 = Replyvote.new(studentid: "1")
    replyvote1.replyvotes_id = "1"
    replyvote1.save
    replyvote2 = Replyvote.new(studentid: "1")
    replyvote2.replyvotes_id = "1"
    replyvote2.save
    expect(Replyvote.where(:studentid => "1")).to have(2).records
  end

  it "Testing deleting of reply votes" do
    replyvote1 = Replyvote.new(studentid: "1")
    replyvote1.replyvotes_id = "1"
    replyvote1.save
    expect(Replyvote.where(:studentid => "1")).to have(1).record
    replyvote1.destroy
    expect(Replyvote.where(:studentid => "1")).to have(0).record
  end
end
