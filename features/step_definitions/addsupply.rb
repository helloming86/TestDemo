#encoding=utf-8
require 'selenium-webdriver'

require File.dirname(__FILE__)+'/action/add_supply_page.rb'
require File.dirname(__FILE__)+'/action/br_op.rb'

假如(/^打开发布供需页面$/) do
  @driver = Br_Op.new(@drr)
  @driver.visit('addsupplyurl')
end


同时(/^维护供需基本信息并点击提交$/) do
  @driver = Add_Supply_Page.new(@drr)
  @driver.addsupply
  @driver.get_Message
  @driver.get_Ajax
end

#检查点

当(/^提示发布需求成功$/) do
  puts "提示信息"
end

并且(/^跳转至供求列表页$/) do
  puts "跳转成功"
end

那么(/^发布供求功能正常$/) do
  puts "功能正常"
  sleep 10
end
