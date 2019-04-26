require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/basic_elements/add_remove_elements_page'
require_relative '../lib/basic_elements/dropdown_page'
require_relative '../lib/basic_elements/status_codes_page'
require 'selenium-webdriver'

describe "Basic elements test" do

  define_method(:spec_helper) { SpecHelper.new(@driver, true) }
  define_method(:main_page) { MainPage.new(@driver, true) }
  define_method(:add_remove_elements_page) { AddRemoveElementsPage.new(@driver, true) }
  define_method(:dropdown_page) { DropdownPage.new(@driver, true) }
  define_method(:status_codes_page) { StatusCodesPage.new(@driver, true) }

  describe "when Main page loaded" do
    before(:all) { spec_helper.open }

    it "heading and example list should have correct text", :aggregate_failures do
        expect(main_page.heading).to eq("Welcome to the-internet")
        expect(main_page.example_list_title).to eq("Available Examples")
    end
  end

  describe "when Add/Remove Elements page loaded" do
    before(:all) do
      spec_helper.open
      main_page.add_remove_elements_link
    end

    it "heading and Add Element button should have correct text, " +
       "Add Element button should be visible, " +
       "Delete Element button should not exist", :aggregate_failures do
        expect(add_remove_elements_page.heading).to eq("Add/Remove Elements")
        expect(add_remove_elements_page.add_element_button?).to be_truthy
        expect(add_remove_elements_page.add_element_button_element.text).to eq("Add Element")
        expect(add_remove_elements_page.delete_element_button?).to be_falsey
    end

    describe "when Add Element button clicked" do
      before(:all) { add_remove_elements_page.add_element_button }
      after(:all) { add_remove_elements_page.delete_element_button }

      it "Delete button should exist and should have correct text", :aggregate_failures do
          expect(add_remove_elements_page.delete_element_button?).to be_truthy
          expect(add_remove_elements_page.delete_element_button_element.text).to eq("Delete")
      end
    end

    describe "when Delete Element button clicked" do
      before(:all) do
        add_remove_elements_page.add_element_button
        add_remove_elements_page.delete_element_button
      end

      it "Delete button should not exist" do
        expect(add_remove_elements_page.delete_element_button?).to be_falsey
      end
    end
  end

  describe "when Dropdown page loaded" do
    before(:all) do
      spec_helper.open
      main_page.dropdown_link
    end

    it "heading should have correct text and dropdown list should have text for blank list", :aggregate_failures do
        expect(dropdown_page.heading).to eq("Dropdown List")
        expect(dropdown_page.dropdown_list).to eq("Please select an option")
    end

    %w(1 2).each do |order|
      context "when option #{order} selected" do
        it "dropdown list should have text for option #{order} selected" do
          dropdown_page.dropdown_list = order
          expect(dropdown_page.dropdown_list).to eq("Option #{order}")
        end
      end
    end
  end

  describe "when Status Code page loaded" do
    before(:all) do
      spec_helper.open
      main_page.status_codes_link
    end

    it "heading should have correct text" do
      expect(status_codes_page.heading).to eq("Status Codes")
    end

    %w(200 301 404 500).each do |code|
      context "when #{code} status code link clicked" do
        it "page content should have #{code} status code" do
          status_codes_page.code_link(code)
          expect(status_codes_page.page_content_text_element.text).to include("This page returned a #{code} status code")
          status_codes_page.status_code_list_link
        end
      end
    end
  end
end
