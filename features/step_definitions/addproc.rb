#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'

require File.dirname(__FILE__)+'/action/add_product_page.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'
require File.dirname(__FILE__)+'/action/br_op.rb'

假如(/^打开发布产品页面$/) do
  @driver = Br_Op.new(@drr)
  @driver.visit('addprocurl')
end

而且(/^维护(.*)试用产品并提交$/) do |trysta|
  @driver = Add_Product_Page.new(@drr)
  @driver.addProduct(trysta)
end

当(/^跳转至厂家产品列表页$/) do
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump(TTENV["testurl"]["comprolisturl"])
end

那么(/^发布产品功能验证通过$/) do
  puts @checkpage
  if  @checkpage
    puts "检查点通过验证，发布产品功能正常"
  else
    puts "检查点未通过验证，发布产品功能异常"
  end
end
