#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'

require File.dirname(__FILE__)+'/action/reg_login_page.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'
require File.dirname(__FILE__)+'/action/br_op.rb'

假如(/^打开注册页面$/) do
  @driver = Br_Op.new(@drr)
  @driver.visit('regurl')
end

同时(/^输入手机密码和验证码注册厂家$/) do
  @driver = User_Reg_Page.new(@drr)
  @driver.regUser
end

当(/^提示注册成功$/) do
  @driver = Check_Dialog.new(@drr)
  @checkdialog = @driver.checkdialog('注册成功')
end

并且(/^跳转至注册资料维护页面$/) do
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump(TTENV["testurl"]["regtoinfourl1"])
end

那么(/^注册功能正常$/) do
  if @checkdialog and @checkpage
    puts "检查点通过验证，注册用户功能正常"
  else
    puts "检查点未通过验证，注册用户功能异常"
  end
end
