#encoding=utf-8
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'pp'
require 'mysql2'
require 'yaml'


require File.dirname(__FILE__)+'/tool/upload_file_com.rb'
require File.dirname(__FILE__)+'/action/upload_file.rb'
require File.dirname(__FILE__)+'/tool/product_att_com.rb'
require File.dirname(__FILE__)+'/action/product_att.rb'
require File.dirname(__FILE__)+'/action/check_method.rb'

#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/testenv.yaml'))
#加载测试数据，用户信息
dt = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/dt.yaml'))


假如(/^打开发布产品页面$/) do
  #打开浏览器并最大化
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.window.maximize
  #打开网址，准备塞入cookie，此步骤不可少，否则，无法塞入cookie
  $driver.get ttenv["testurl"]["loginurl"]
  $driver.manage.all_cookies
  $driver.manage.delete_all_cookies
  $driver.manage.add_cookie(name: 'JSESSIONID', value: dt["testcookie"]["jssion"])
  $driver.manage.add_cookie(name: 'username', value: dt["testcookie"]["juname"])
  $driver.manage.add_cookie(name: 'pwd', value: dt["testcookie"]["jpwd"])
  sleep 2
  #打开发布产品页面
  $driver.get ttenv["testurl"]["addprocurl"]
end

而且(/^维护产品基本信息$/) do
  @driver = Add_Product.new($driver)
  @driver.setProTemp
  @driver.setProName
  @driver.setProItem
  @driver.setProArea
  @driver.setProCrowd
  @driver.setProChannel
  @driver.setProPolicy
end

同时(/^上传产品图片和产品详情$/) do
  @driver = Upload_file.new($driver)
  @driver.upload('propic')
  @driver.upload('prodetpic')
end

同时(/^设置(.*)试用$/) do |trysta|
  @driver = Add_Product.new($driver)
  if /^不可$/ =~ trysta
    @driver.setProTry(0)
  else
    @driver.setProTry(1)
  end
end

并且(/^点击发布产品$/) do
  sleep 2
  @driver = Add_Product.new($driver)
  @driver.do_AddPro
end


当(/^提示发布产品成功$/) do
  @driver = Check_Dialog.new($driver)
  @checkdialog = @driver.checkdialog('发布成功')
end


并且(/^跳转至厂家产品列表页$/) do
  sleep 5
  @driver = Check_PageJump.new($driver)
  @checkpage = @driver.checkpagejump('toProductMngList.do?page')
end

那么(/^发布产品功能验证通过$/) do
  if @checkdialog and @checkpage
    puts "检查点通过验证，发布产品功能正常"
  else
    puts "检查点未通过验证，发布产品功能异常"
  end
  $driver.quit
end
