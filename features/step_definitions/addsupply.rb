#encoding=utf-8
require 'selenium-webdriver'
require 'net/http'
require 'json'

require File.dirname(__FILE__)+'/action/add_supply_page.rb'
require File.dirname(__FILE__)+'/action/br_op.rb'

假如(/^打开发布供需页面$/) do
  @driver = Br_Op.new(@drr)
  @driver.visit('addsupplyurl')
end


同时(/^维护供需基本信息并点击提交$/) do
  @driver = Add_Supply_Page.new(@drr)
  @driver.addsupply
end

#检查点

当(/^提示发布需求成功$/) do
  @driver = Check_Dialog.new(@drr)
  @checkdialog = @driver.checkdialog('发布成功')
end

并且(/^跳转至供求列表页$/) do
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump(TTENV["testurl"]["suplisturl"])
end

那么(/^发布供求功能正常$/) do
  puts @checkdialog,@checkpage
  if @checkdialog and @checkpage
    puts "检查点通过验证，注册用户功能正常"
  else
    puts "检查点未通过验证，注册用户功能异常"
  end
end
