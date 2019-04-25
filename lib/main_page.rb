require_relative '../lib/base_page'
require 'page-object'

class MainPage < BasePage
  include PageObject

  element(:heading, css: ".heading")
  element(:example_list_title, css: "h2")
  link(:add_remove_elements_link, css: "[href=\"/add_remove_elements/\"]")
  link(:dropdown_link, css: "[href=\"/dropdown\"]")
  link(:status_codes_link, css: "[href=\"/status_codes\"]")
  link(:form_authentication_link, css: "[href=\"/login\"]")
  link(:horizontal_slider_link, css: "[href=\"/horizontal_slider\"]")
end
