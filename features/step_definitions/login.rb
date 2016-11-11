#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'
require 'yaml'

#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/testenv.yaml'))
#加载测试数据，用户信息
dt = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/dt.yaml'))

#启动浏览器打开登录页面
$caps = Selenium::WebDriver::Remote::Capabilities.chrome
$huburl = ttenv["visgrid"]["hubrul"]

假如(/^打开登录页面$/) do
  #打开浏览器，方法一，远程调用，保证多人开发时环境是统一的
  #$driver = Selenium::WebDriver.for(:remote,:url => $huburl,:desired_capabilities => $caps)
  #打开浏览器，方法二，本地调用
  $driver = Selenium::WebDriver.for :chrome
  $driver.manage.window.maximize
  $driver.manage.delete_all_cookies
  $driver.get ttenv["testurl"]["loginurl"]
end

当(/^输入(.*)的用户名和密码$/) do |uinfo|
  $driver.find_element(:id,'loginName').send_keys(dt["testuser"]["phone"])
  if /^正确$/ =~ uinfo
      $driver.find_element(:id,'loginPwd').send_keys(dt["testuser"]["password"])
    else
      $driver.find_element(:id,'loginPwd').send_keys('123123')
  end
end

当(/^点击登录按钮$/) do
  $driver.find_element(:id,'loginSubmit').click
end

#检查点：登录成功的弹窗和提示

那么(/^弹出登录(.*)提示$/) do |lsta|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  if /^登录成功！$/ =~ $driver.find_element(:class,'ui_dialog').text then
    puts  "登录成功呵呵呵2"
    p $driver.manage.all_cookies
  else
    puts  "登录失败呵呵呵2"
  end
  #关闭浏览器
  $driver.quit
end
