require 'spec_helper'

describe "Admin" do

  describe "signin" do

    describe "success" do

      it "should login as an admin" do
        lambda do
          visit "page_login_urls"
          fill_in "Username",     :with => "super"
          fill_in "Password",     :with => "super"

          click_button
          response.should render_template('page/home')
        end
      end
    end


    describe "failure" do

      it "should not login as an admin" do
        lambda do
          visit "page_login_urls"
          fill_in "Username",     :with => ""
          fill_in "Password",     :with => ""

          click_button
          response.should render_template('page/login')
        end
      end
    end
  end
end



