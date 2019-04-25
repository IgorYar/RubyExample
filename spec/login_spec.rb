require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/login/login_page'
require 'selenium-webdriver'

describe "Login test" do
  subject { @login_page }

  let(:invalid_value) { "qwerty" }

  before(:all) do
    @spec_helper = SpecHelper.new(@driver, true)
    @main_page = MainPage.new(@driver, true)
    @login_page = LoginPage.new(@driver, true)
  end

  before(:each) do
    @spec_helper.open
    @main_page.form_authentication_link
  end

  describe "when Login page loaded" do
    it "heading should have correct text" do
      expect(subject.heading).to eq("Login Page")
    end
  end

  describe "when invalid username" do
    it "error message should have correct text" do
      subject.login(invalid_value, subject.valid_password)
      expect(subject.flash_message_bar_element.text).to include("Your username is invalid!")
    end
  end

  describe "when invalid password" do
    it "error message should have correct text" do
      subject.login(subject.valid_username, invalid_value)
      expect(subject.flash_message_bar_element.text).to include("Your password is invalid!")
    end
  end

  describe "when valid login data" do
    before(:each) do
      @login_page.login(@login_page.valid_username, @login_page.valid_password)
    end

    it "success login message should appear, heading and logout button should have correct text" do
      expect(subject.flash_message_bar_element.text).to include("You logged into a secure area!")
      expect(subject.heading).to eq("Secure Area")
      expect(subject.logout_button_element.text).to eq("Logout")
    end

    it "after logout heading should have correct text" do
      subject.logout_button
      expect(subject.heading).to eq("Login Page")
    end
  end
end
