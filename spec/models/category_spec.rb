require 'spec_helper'

describe Category do
  it "There are no categories in database" do
    expect(Category).to have(:no).records
    expect(Category).to have(0).records
  end

  it "counts only Categories that match a query" do
    user = Category.create!(categoryname: "OOLS")
    expect(Category.where(:categoryname => "OOLS")).to have(1).record
    expect(Category.where(:categoryname => "ALGO")).to have(0).records
  end

  it "Create Category and check count is 1" do
    category = Category.create!(categoryname: "OOLS")
    expect(Category.count).to eq(1)
    category = Category.create!(categoryname: "ALGO")
    expect(Category.count).to eq(2)
  end

  it "Create Category and delete the same" do
    category = Category.create!(categoryname: "OOLS")
    expect(Category.count).to eq(1)
    category.destroy
    expect(Category.count).to eq(0)
  end

  it "Update Category" do
    category = Category.create!(categoryname: "OOLS")
    expect(Category.count).to eq(1)
    category.update_attributes(:categoryname => "ALGO")
    expect(Category.where(:categoryname => "OOLS")).to have(0).record
    expect(Category.where(:categoryname => "ALGO")).to have(1).records
  end

end
