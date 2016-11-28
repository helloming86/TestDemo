#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'

require File.dirname(__FILE__)+'/page/index_page.rb'
require File.dirname(__FILE__)+'/common/br_op.rb'

假如(/^打开首页$/) do
  puts "1"
  @driver = Br_Op.new(@drr)
  puts "2"
  @driver.visit('indexurl')
  puts "3"
  sleep 5
end

当(/^定位到友情链接并且点击正常跳转$/) do
  puts "hahah"
  @driver = Index_Page.new(@drr)
  puts @driver.testFriendLink
end

#检查点：
那么(/^友情链接正常$/) do
  puts "呵呵呵"
end

当(/^定位到市场供求并且点击正确跳转$/) do
  puts "hahah"
  @driver = Index_Page.new(@drr)
  @driver.testHotSupply
end

#检查点：
那么(/^市场供求正常$/) do
  puts "呵呵呵"
end
