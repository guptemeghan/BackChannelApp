require 'spec_helper'

describe Postvote do
  it "There are no post votes in database" do
    expect(Postvote).to have(:no).records
    expect(Postvote).to have(0).records
  end

  it "Creating two post votes in database" do
    postvote1 = Postvote.new(studentid: "1")
    postvote1.post_id = "1"
    postvote1.save
    postvote2 = Postvote.new(studentid: "1")
    postvote2.post_id = "1"
    postvote2.save
    expect(Postvote.where(:studentid => "1")).to have(2).records
  end

  it "Testing deleting of votes" do
    postvote1 = Postvote.new(studentid: "1")
    postvote1.post_id = "1"
    postvote1.save
    expect(Postvote.where(:studentid => "1")).to have(1).record
    postvote1.destroy
    expect(Postvote.where(:studentid => "1")).to have(0).record
  end

end
