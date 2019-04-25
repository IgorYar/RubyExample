require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/basic_elements/add_remove_elements_page'
require_relative '../lib/basic_elements/dropdown_page'
require_relative '../lib/basic_elements/status_codes_page'
require 'selenium-webdriver'

describe "Basic elements test" do

  let(:spec_helper) { SpecHelper.new(@driver, true) }
  let(:main_page) { MainPage.new(@driver, true) }
  let(:add_remove_elements_page) { AddRemoveElementsPage.new(@driver, true) }
  let(:dropdown_page) { DropdownPage.new(@driver, true) }
  let(:status_codes_page) { StatusCodesPage.new(@driver, true) }

  describe "when Main page loaded" do
    before(:each) { spec_helper.open }

    it "heading should have correct text" do
      expect(main_page.heading).to eq("Welcome to the-internet")
    end

    it "example list should have correct title" do
      expect(main_page.example_list_title).to eq("Available Examples")
    end
  end

  describe "when Add/Remove Elements page loaded" do
    before(:each) { spec_helper.open }

    let!(:open_add_remove_elements_page) { main_page.add_remove_elements_link }

    it "heading should have correct text" do
      expect(add_remove_elements_page.heading).to eq("Add/Remove Elements")
    end

    it "Add Element button should be visible" do
      expect(add_remove_elements_page.add_element_button?).to be_truthy
    end

    it "Add Element button should have correct text" do
      expect(add_remove_elements_page.add_element_button_element.text).to eq("Add Element")
    end

    it "Delete Element button should not exist" do
      expect(add_remove_elements_page.delete_element_button?).to be_falsey
    end

    describe "when Add Element button clicked" do
      before(:each) { add_remove_elements_page.add_element_button }

      it "Delete button should exist" do
        expect(add_remove_elements_page.delete_element_button?).to be_truthy
      end

      it "Add Element button should have correct text" do
        expect(add_remove_elements_page.delete_element_button_element.text).to eq("Delete")
      end
    end

    describe "when Delete Element button clicked" do
      it "Delete button should not exist" do
        add_remove_elements_page.add_element_button
        add_remove_elements_page.delete_element_button
        expect(add_remove_elements_page.delete_element_button?).to be_falsey
      end
    end
  end

  describe "when Dropdown page loaded" do
    before(:each) do
      spec_helper.open
      main_page.dropdown_link
    end

    it "heading should have correct text" do
      expect(dropdown_page.heading).to eq("Dropdown List")
    end

    it "dropdown list should have text for blank list selected" do
      expect(dropdown_page.dropdown_list).to eq("Please select an option")
    end

    describe "when first option selected" do
      it "dropdown list should have text for first option selected" do
        dropdown_page.dropdown_list="1"
        expect(dropdown_page.dropdown_list).to eq("Option 1")
      end
    end

    describe "when second option selected" do
      it "dropdown list should have text for first option selected" do
        dropdown_page.dropdown_list="2"
        expect(dropdown_page.dropdown_list).to eq("Option 2")
      end
    end
  end

  describe "when Status Code page loaded" do
    before(:each) do
      spec_helper.open
      main_page.status_codes_link
    end

    it "heading should have correct text" do
      expect(status_codes_page.heading).to eq("Status Codes")
    end

    describe "when each status code link clicked" do
      %w(200 301 404 500).each do |code|
        describe "when #{code} status code link clicked" do
          it 'page context should have correct text' do
            status_codes_page.code_link(code)
            expect(status_codes_page.page_content_text_element.text).to include("This page returned a #{code} status code")
            status_codes_page.status_code_list_link
          end
        end
      end
    end
  end
end
