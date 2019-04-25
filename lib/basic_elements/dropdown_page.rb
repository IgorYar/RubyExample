require_relative '../../lib/base_page'
require 'page-object'

class DropdownPage < BasePage
  include PageObject

  select_list(:dropdown_list, id: "dropdown")
end
