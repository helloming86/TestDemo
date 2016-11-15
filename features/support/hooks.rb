require 'watir'
require 'selenium-webdriver'

Before do
  #Before("@hotel") do          #tagged hooks
  puts "This is before hook."
  @drr = Watir::Browser.new :chrome
  @drr.window.maximize
end

After do
  #After("@hotel") do           #tagged hooks
  puts "This is after hook."
  @drr.close
  
end
