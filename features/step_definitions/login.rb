#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'
require 'yaml'

require File.dirname(__FILE__)+'/action/reg_login_page.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'

#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../support/test_data/testenv.yaml'))

假如(/^打开登录页面$/) do
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.window.maximize
  $driver.manage.delete_all_cookies
  $driver.get ttenv["testurl"]["loginurl"]
end

同时(/^输入(.*)的用户名和密码并登陆$/) do |uinfo|
  @driver = User_Login_Page.new($driver)
  @driver.login(uinfo)
end

#检查点：登录成功的弹窗和提示

那么(/^弹出(.*)登录提示$/) do |ustat|
  @driver = Check_Dialog.new($driver)
  @checkdialog = @driver.checkdialog(ustat)
end

那么(/^登录功能正常$/) do
  if @checkdialog then
    puts "检查点通过验证，登录功能正常"
  else
    puts "检查点未通过验证，登录功能异常"
  end
  $driver.quit
end
