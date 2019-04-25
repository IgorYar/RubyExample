require_relative '../helper/spec_helper'
require_relative '../lib/main_page'
require_relative '../lib/slider/horizontal_slider_page'
require 'selenium-webdriver'

describe "Horizontal slider test" do
  subject { @slider_page }

  let(:invalid_value) { "qwerty" }

  before(:all) do
    @spec_helper = SpecHelper.new(@driver, true)
    @main_page = MainPage.new(@driver, true)
    @slider_page = HorizontalSliderPage.new(@driver, true)
  end

  before(:each) do
    @spec_helper.open
    @main_page.horizontal_slider_link
  end

  describe "when Horizontal slider page loaded" do
    it "heading should have correct text" do
      expect(subject.heading).to eq("Horizontal Slider")
    end
  end

  describe "when move slider" do
    RIGHT_STEPS_NUMBER = 5
    LEFT_STEPS_NUMBER = 2
    STEP_MULTIPLIER = 0.5

    before(:each) { subject.slider_element.hover }

    describe "to the right" do
      it "the range should have correct value" do
        subject.move_slider("right", RIGHT_STEPS_NUMBER)
        expect(subject.range).to eq("#{RIGHT_STEPS_NUMBER/2.0}")
      end
    end

    describe "to the right and then to the left" do
      it "the range should have correct value" do
        subject.move_slider("right", RIGHT_STEPS_NUMBER)
        subject.move_slider("left", LEFT_STEPS_NUMBER)
        expect(subject.range).to eq("#{RIGHT_STEPS_NUMBER*STEP_MULTIPLIER - LEFT_STEPS_NUMBER*STEP_MULTIPLIER}")
      end
    end
  end
end
