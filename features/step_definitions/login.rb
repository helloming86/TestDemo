#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'
require 'yaml'

require File.dirname(__FILE__)+'/action/reg_login.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'

#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/testenv.yaml'))

假如(/^打开登录页面$/) do
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.window.maximize
  $driver.manage.delete_all_cookies
  $driver.get ttenv["testurl"]["loginurl"]
end

同时(/^输入(.*)的用户名和密码$/) do |uinfo|
  @driver = User_Login.new($driver)
  @driver.setLoginName
  @driver.setLoginPwd(uinfo)
end

而且(/^点击登录按钮$/) do
  @driver = User_Login.new($driver)
  @driver.do_Login
end

#检查点：登录成功的弹窗和提示

那么(/^弹出(.*)登录提示$/) do |ustat|
  @driver = Check_Dialog.new($driver)
  @checkdialog = @driver.checkdialog(ustat)
  #关闭浏览器
  $driver.quit
end
