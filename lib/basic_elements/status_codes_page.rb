require_relative '../../lib/base_page'
require 'page-object'

class StatusCodesPage < BasePage
  include PageObject

  element(:page_content_text, css: "p")
  link(:status_code_list_link, css: "[href=\"/status_codes\"]")

  link(:code_200, css: "[href=\"status_codes/200\"]")
  link(:code_301, css: "[href=\"status_codes/301\"]")
  link(:code_404, css: "[href=\"status_codes/404\"]")
  link(:code_500, css: "[href=\"status_codes/500\"]")

  def code_link(code)
    send("code_#{code}")
  end
end
