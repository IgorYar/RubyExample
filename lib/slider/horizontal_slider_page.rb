require_relative '../../lib/base_page'
require 'page-object'

class HorizontalSliderPage < BasePage
  include PageObject

  element(:slider, css: "[type=\"range\"]")
  element(:range, id: "range")

  def move_slider(direction, step)
    if direction == "right"
      looped_key_press(step, :arrow_right)
    elsif direction == "left"
      looped_key_press(step, :arrow_left)
    else
      raise "Invalid direction passed; \"right\" or \"left\" allowed only"
    end
  end

  def looped_key_press(step, key)
    step.times do
      self.slider_element.send_keys(key)
    end
  end
end