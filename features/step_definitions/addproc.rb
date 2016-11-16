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
  @driver.get_Message
  @driver.get_Ajax
end

当(/^提示发布产品成功$/) do
  @driver = Check_Dialog.new(@drr)
  @checkdialog = @driver.checkdialog('发布成功')
end


并且(/^跳转至厂家产品列表页$/) do
  sleep 5
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump('toProductMngList.do?page')
end

那么(/^发布产品功能验证通过$/) do
  if @checkdialog and @checkpage
    puts "检查点通过验证，发布产品功能正常"
  else
    puts "检查点未通过验证，发布产品功能异常"
  end
end
