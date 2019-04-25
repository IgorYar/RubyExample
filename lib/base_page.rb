require 'page-object'

class BasePage
  include PageObject

  element(:heading, css: "h3")
end
