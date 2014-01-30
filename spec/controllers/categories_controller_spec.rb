require 'spec_helper'
require 'categories_controller'
describe "Category" do
  render_views
  describe "create" do

    describe "success" do

      it "should create a new category" do
        lambda do
          visit"category_new_path"
          post :create, :categoryname => "text"
          fill_in "CategoryName",:with => "Meghan"
          click_button
          response.should change(Category, :count).by (1)
          response.should render_template('category/index')
      end
      end

    end
    describe "failure" do

      it "should not create a new category" do
        lambda do
          visit "categories_new_path"
          fill_in "CategoryName",:with => ""

          click_button
          response.should render_template('category/new')
        end
      end
    end


  end

  describe "Show" do
    it "should show all categories" do
      lambda do
        visit "page_home_path"

        click_link
        response.should render_template('category/index')
      end
    end
  end

end



