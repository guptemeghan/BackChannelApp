require 'spec_helper'

describe Tag do
  it "There are no tags in database" do
    expect(Tag).to have(:no).records
    expect(Tag).to have(0).records
  end

  it "Return tags that match a query" do
    tag = Tag.create!(tagname: "OOLS")
    expect(Tag.where(:tagname => "OOLS")).to have(1).record
    expect(Tag.where(:tagname => "ALGO")).to have(0).records
  end

  it "Create Tags and check count is 1 or 2" do
    tag = Tag.create!(tagname: "OOLS")
    expect(Tag.count).to eq(1)
    tag = Tag.create!(tagname: "ALGO")
    expect(Tag.count).to eq(2)
  end

  it "Create Category and delete the same" do
    tag = Tag.create!(tagname: "OOLS")
    expect(Tag.count).to eq(1)
    tag.destroy
    expect(Tag.count).to eq(0)
  end

  it "Update Tag" do
    tag = Tag.create!(tagname: "OOLS")
    expect(Tag.count).to eq(1)
    tag.update_attributes(:tagname => "ALGO")
    expect(Tag.where(:tagname => "OOLS")).to have(0).record
    expect(Tag.where(:tagname => "ALGO")).to have(1).records
  end


end
