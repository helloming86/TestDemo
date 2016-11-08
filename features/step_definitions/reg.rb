#encoding=utf-8
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'pp'
require 'mysql2'
require 'yaml'

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
  $driver.find_element(:id,'phone').send_keys('17911111166')
  $driver.find_element(:id,'password').send_keys('123123')
end

同时(/^选择我是厂家$/) do
  $driver.find_element(:class,'guide_c').find_element(:id,'three1').click
end

并且(/^点击获取验证码$/) do
  $driver.find_element(:id,'getcheckCode').click
end

当(/^提示验证码获取成功后输入验证码$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 5)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  if /^验证码发送成功！$/ =~ $driver.find_element(:class,'ui_dialog').text then
    puts  "验证码已发送"
    #连接mysql数据库，获取验证码
    puts  "获取数据库配置文件"
    puts Dir.pwd
    puts Dir.chdir(File.dirname(__FILE__))
    dblk = YAML.load(File.open("E:\\RubyTestProject\\TestDemo\\features\\step_definitions\\db.yaml"))
    puts "获取到的数据库IP：" + dblk["test"]["host"].to_s
    puts "获取到的数据库Port：" + dblk["test"]["port"].to_s
    puts "获取到的数据库实例名：" + dblk["test"]["database"].to_s
    puts "获取到的数据库用户名：" + dblk["test"]["username"].to_s
    puts "获取到的数据库密码：" + dblk["test"]["password"].to_s
    puts  "连接数据库，获取验证码"
    client = Mysql2::Client.new(:host => "#{dblk["test"]["host"].to_s}", :username => "#{dblk["test"]["username"].to_s}",:password => "#{dblk["test"]["password"].to_s}",:database => "#{dblk["test"]["database"].to_s}",:port => "#{dblk["test"]["port"].to_s}")
    #client = Mysql2::Client.new(:host => "114.55.86.57", :username => "root",:password => "315625",:database => "qtkj_fmcgbn_test",:port => "3306")
    results = client.query("SELECT code FROM t_sms_record where mobile = '17911111166' ORDER BY date DESC LIMIT 1")
    if results.count == 0 then
      puts "未查询到验证码，进程终止"
      $driver.quit
    else
      rcode = Hash.new
      results.each do |regcode|
          puts regcode
          rcode = regcode
      end
      puts rcode
      puts  "获取的验证码是：" + rcode['code']
      $driver.find_element(:id,'code').send_keys("#{rcode['code']}")
    end
  else
    puts  "验证码获取失败"
    puts  "失败原因：" + $driver.find_element(:class,'ui_dialog').text
  end
end

并且(/^点击注册账号$/) do
  sleep 6 #因为注册页面在验证码和注册都有弹窗提示，故在提交注册前等待6秒，确保两个弹窗能分别获取和处理
  $driver.find_element(:id,'submit1').click
end

#检查点：注册成功的弹窗和提示

假如(/^提示注册成功$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  puts "弹窗提示：" + $driver.find_element(:class,'ui_dialog').text
  if /注册成功/ =~ $driver.find_element(:class,'ui_dialog').text then
    @regstat = true
  else
    @regstat = false
  end
end

那么(/^注册成功并跳转至厂家资料维护页面$/) do
  #判断是否注册成功
  if @regstat then
    puts @regstat
    puts "注册成功"
  else
    puts "注册失败"
  end

  #正则表达式判断跳转页面是否正常
  sleep 5
  if /user\/info0.do/ =~ $driver.current_url then
    puts "页面正确跳转"
    puts "跳转页面的Title为：#{$driver.title}"
    puts "跳转页面的URL为：#{$driver.current_url}"
  else
    puts  "页面未正确跳转"
  end

end
