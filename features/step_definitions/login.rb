#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'

require File.dirname(__FILE__)+'/action/reg_login_page.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'
require File.dirname(__FILE__)+'/action/br_op.rb'

假如(/^打开登录页面$/) do
  @driver = Br_Op.new(@drr)
  @driver.visit('loginurl')
end

同时(/^输入(.*)的用户名和密码并登陆$/) do |uinfo|
  @driver = User_Login_Page.new(@drr)
  @driver.login(uinfo)
end

#检查点：登录成功的弹窗和提示

那么(/^弹出(.*)登录提示$/) do |ustat|
  @driver = Check_Dialog.new(@drr)
  @checkdialog = @driver.checkdialog(ustat)
end

那么(/^登录功能正常$/) do
  if @checkdialog then
    puts "检查点通过验证，登录功能正常"
  else
    puts "检查点未通过验证，登录功能异常"
  end
end
