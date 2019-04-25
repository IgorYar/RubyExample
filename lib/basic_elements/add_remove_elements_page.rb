require_relative '../../lib/base_page'
require 'page-object'

class AddRemoveElementsPage < BasePage
  include PageObject

  button(:add_element_button, css: "[onclick=\"addElement()\"]")
  button(:delete_element_button, css: "[onclick=\"deleteElement()\"]")
end
