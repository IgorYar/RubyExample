require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/slider/horizontal_slider_page'
require 'selenium-webdriver'

describe "Horizontal slider test" do

  define_method(:spec_helper) { SpecHelper.new(@driver, true) }
  define_method(:main_page) { MainPage.new(@driver, true) }
  define_method(:slider_page) { HorizontalSliderPage.new(@driver, true) }

  before(:each) do
    spec_helper.open
    main_page.horizontal_slider_link
  end

  describe "when Horizontal slider page loaded" do
    it "heading should have correct text" do
      expect(slider_page.heading).to eq("Horizontal Slider")
    end
  end

  describe "when move slider" do
    RIGHT_STEPS_NUMBER = 5
    LEFT_STEPS_NUMBER = 2
    STEP_MULTIPLIER = 0.5

    before(:each) do
      slider_page.slider_element.hover
      slider_page.move_slider("right", RIGHT_STEPS_NUMBER)
    end

    describe "to the right" do
      it "the range should have correct value" do
        expect(slider_page.range).to eq("#{RIGHT_STEPS_NUMBER/2.0}")
      end
    end

    describe "to the right and then to the left" do
      before(:each) { slider_page.move_slider("left", LEFT_STEPS_NUMBER) }

      it "the range should have correct value" do
        expect(slider_page.range).to eq("#{RIGHT_STEPS_NUMBER*STEP_MULTIPLIER - LEFT_STEPS_NUMBER*STEP_MULTIPLIER}")
      end
    end
  end
end
