require_relative '../../lib/base_page'
require 'page-object'

class LoginPage < BasePage
  include PageObject

  element(:heading, css: "h2")
  text_field(:username, css: "[name=\"username\"]")
  text_field(:password, css: "[name=\"password\"]")
  button(:login_button, css: ".radius")
  link(:logout_button, css: "[href=\"/logout\"]")
  element(:flash_message_bar, css: ".flash")
  elements(:login_data_list, css: "em")

  def valid_username
    self.login_data_list_elements[0].text
  end

  def valid_password
    self.login_data_list_elements[1].text
  end

  def login(username, password)
    self.username = username
    self.password = password
    self.login_button
  end
end
