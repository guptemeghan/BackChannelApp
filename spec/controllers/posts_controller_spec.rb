require 'spec_helper'

describe "Posts" do

  describe "Create" do

    describe "success" do

      it "should create a new post" do
        lambda do
          visit "posts_new_url"
          fill_in "Title",:with => "Example Title"
          fill_in "Post Description",:with => "This is the post description"
          fill_in "tag",:with => "OOLS"
          fill_in "Category",:with => "Homework1"
          click_button
          response.should render_template('posts/new')
        end
      end
    end


    describe "failure" do

      it "should not create a new post" do
        lambda do
          visit "posts_new_url"
          fill_in "Title",:with => ""
          fill_in "Post Description",:with => ""
          fill_in "tag",:with => ""
          fill_in "Category",:with => ""

          click_button
          response.should render_template('posts/new')
        end
      end
    end
  end
end



