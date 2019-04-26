require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/login/login_page'
require 'selenium-webdriver'

describe "Login test" do

  INVALID_VALUE = "qwerty"

  define_method(:spec_helper) { SpecHelper.new(@driver, true) }
  define_method(:main_page) { MainPage.new(@driver, true) }
  define_method(:login_page) { LoginPage.new(@driver, true) }

  before(:each) do
    spec_helper.open
    main_page.form_authentication_link
  end

  describe "when Login page loaded" do
    it "heading should have correct text" do
      expect(login_page.heading).to eq("Login Page")
    end
  end

  describe "when invalid username" do
    before(:each) { login_page.login(INVALID_VALUE, login_page.valid_password) }

    it "error message should have correct text" do
      expect(login_page.flash_message_bar_element.text).to include("Your username is invalid!")
    end
  end

  describe "when invalid password" do
    before(:each) { login_page.login(login_page.valid_username, INVALID_VALUE) }

    it "error message should have correct text" do
      expect(login_page.flash_message_bar_element.text).to include("Your password is invalid!")
    end
  end

  describe "when valid login data" do
    before(:each) do
      login_page.login(login_page.valid_username, login_page.valid_password)
    end

    it "success login message should appear, heading and logout button should have correct text", :aggregate_failures do
      expect(login_page.flash_message_bar_element.text).to include("You logged into a secure area!")
      expect(login_page.heading).to eq("Secure Area")
      expect(login_page.logout_button_element.text).to eq("Logout")
    end

    it "after logout heading should have correct text" do
      login_page.logout_button
      expect(login_page.heading).to eq("Login Page")
    end
  end
end
