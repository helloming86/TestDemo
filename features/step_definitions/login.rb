#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'


#启动浏览器打开登录页面

=begin
  selenium grid xiefa
$caps = Selenium::WebDriver::Remote::Capabilities.chrome
$huburl = 'http://192.168.1.60:4444/wd/hub'
$driver = Selenium::WebDriver.for(:remote,:url => $huburl,:desired_capabilities => $caps)
=end

假如(/^打开登录页面$/) do
  if $driver.nil?
    $driver = Selenium::WebDriver.for :chrome
  end
  $driver.manage.delete_all_cookies
  $driver.get "http://tranhuo.com/toLogin.html?locationurl=http://tranhuo.com/index.html"
end

当(/^输入(.*)的用户名和密码$/) do |uinfo|
  $driver.find_element(:id,'loginName').send_keys('17703818657')
  if /^正确$/ =~ uinfo
      $driver.find_element(:id,'loginPwd').send_keys('123123')
    else
      $driver.find_element(:id,'loginPwd').send_keys('111111')
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
    puts  "登录成功呵呵呵"
  else
    puts  "登录失败呵呵呵"
  end
  #关闭浏览器
  #$driver.quit
end


