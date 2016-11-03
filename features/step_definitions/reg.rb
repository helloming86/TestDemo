#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'
require 'pp'
require 'mysql2'


#启动浏览器打开登录页面
$caps = Selenium::WebDriver::Remote::Capabilities.chrome
$huburl = 'http://localhost:4444/wd/hub'

假如(/^打开注册页面$/) do
  if $driver.nil?
    $driver = Selenium::WebDriver.for(:remote,:url => $huburl,:desired_capabilities => $caps)
  end
  $driver.manage.window.maximize
  $driver.manage.delete_all_cookies
  $driver.get "http://tranhuo.cn:8086/toRegister.html"
end

当(/^输入手机号和密码$/) do
  $driver.find_element(:id,'phone').send_keys('17811111145')
  $driver.find_element(:id,'pasword').send_keys('123123')
end

同时(/^选择我是厂家$/) do
  $driver.find_element(:class,'guide_c').find_element(:id,'three1').click
end

并且(/^点击获取验证码$/) do
  $driver.find_element(:id,'getcheckCode').click
end

当(/^提示验证码获取成功后输入验证码$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  if /^验证码发送成功$/ =~ $driver.find_element(:class,'ui_dialog').text then
    puts  "验证码已获取"
    #连接mysql数据库，获取验证码
    client = Mysql2::Client.new(:host => "114.55.86.57", :username => "root",:password => "315625",:database => "qtkj_fmcgbn_test",:port => "3306")
    results = client.query("SELECT code FROM t_sms_record where mobile = '17811111145' ORDER BY date DESC LIMIT 1")
    results.each do |regcode|
      puts regcode
    end
    puts  "获取的验证码是：" + regcode

    $driver.find_element(:id,'code').send_keys(regcode)
  else
    puts  "该手机号码不能注册"
  end
end

并且(/^点击注册账号$/) do
  $driver.find_element(:id,'submit1').click
end

#检查点：注册成功的弹窗和提示

假如(/^提示注册成功$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  if /^注册成功！$/ =~ $driver.find_element(:class,'ui_dialog').text then
    puts "用户注册成功"
  else
    puts "用户注册失败"
  end
end

那么(/^厂家注册成功并跳转至厂家资料维护页面$/) do
  #捕获新窗口

  #所有窗口句柄
  hs = $driver.window_handles
  #当前窗口句柄
  ch = $driver.window_handle

  pp hs
  pp ch

  hs.each do |h|
    unless h==ch
      p $driver.title
      $driver.switch_to.window(h)
      p $driver.title
    end
  end

end
