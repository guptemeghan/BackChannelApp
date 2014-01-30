require 'spec_helper'

describe "Page" do

  describe "signup" do

    describe "success" do

      it "should make a new user" do
        lambda do
          visit "page_login_urls"
          fill_in "Name",:with => "Example User"
          fill_in "Email address",:with => "user@example.com"
          fill_in "Student Id",:with => "200018187"
          fill_in "Username",:with => "username"
          fill_in "Password",:with => "username"
          fill_in "Confirm Password",:with => "username"
          click_button
          response.should render_template('page/home')
        end
      end
    end


describe "failure" do

  it "should not make a new user" do
    lambda do
      visit "page_login_urls"
      fill_in "Name",         :with => ""
      fill_in "Email address",        :with => ""
      fill_in "Student Id",     :with => ""
      fill_in "Username",     :with => ""
      fill_in "Password",     :with => ""
      fill_in "Confirm Password", :with => ""

      click_button
      response.should render_template('page/login')
    end
  end
end
  end

  describe "Signin" do
    it "should login an existing user" do
      lambda do
        visit "page_login_urls"
        fill_in "Username",     :with => "username"
        fill_in "Password",     :with => "username"
        click_button
        page.should have_content('Login Successful')
        response.should render_template('page/home')
      end
    end
    it "should not login an existing user" do
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



