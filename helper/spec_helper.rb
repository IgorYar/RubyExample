require 'selenium-webdriver'
require 'page-object'

class SpecHelper
  include PageObject

  BASE_URL = "http://the-internet.herokuapp.com"

  def open(url = BASE_URL)
    navigate_to(url)
  end

end

RSpec.configure do |config|
  config.before(:all) do
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.window.maximize
    @driver.manage.timeouts.implicit_wait = 3
  end

  config.after(:all) do
    @driver.quit
  end
end
