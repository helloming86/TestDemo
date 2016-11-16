require 'selenium-webdriver'
require 'yaml'

Before do

  puts "This is before hook."
  #@drr = Watir::Browser.new :chrome
  #@drr.window.maximize
  @drr = Selenium::WebDriver.for :chrome
  @drr.manage.window.maximize
end

After do

  puts "This is after hook."
  @drr.quit

end
