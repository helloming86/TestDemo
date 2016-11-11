#encoding=utf-8
require 'rubygems'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'pp'
require 'mysql2'
require 'yaml'
require 'win32ole'

require File.dirname(__FILE__)+'/tool/upload_file_com.rb'
require File.dirname(__FILE__)+'/action/upload_file.rb'


#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/testenv.yaml'))
#加载测试数据，用户信息
dt = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/dt.yaml'))

puts "hahahaha"

假如(/^打开发布产品页面$/) do
  #打开浏览器
  $driver = Selenium::WebDriver.for :chrome
  #打开网址，准备塞入cookie，此步骤不可少，否则，无法塞入cookie
  $driver.get ttenv["testurl"]["loginurl"]
  $driver.manage.window.maximize
  $driver.manage.all_cookies
  $driver.manage.delete_all_cookies
  $driver.manage.add_cookie(name: 'JSESSIONID', value: '8A09E896E3169E8993DEEABFA89497D2')
  $driver.manage.add_cookie(name: 'username', value: '17811111112')
  $driver.manage.add_cookie(name: 'pwd', value: '8758F78AFCAFC134978E05D6AE679479')
  sleep 2
  #打开发布产品页面
  $driver.get ttenv["testurl"]["addprocurl"]
end



当(/^选择模板和产品分类$/) do
  #选择下拉列表
  $driver.find_element(:name,'templeteNum').find_elements(:tag_name, 'option')[1].click()
  #执行js
  #$driver.execute_script('$("#select_job").val("休闲食品").click();')
  #$driver.execute_script('$("#select_job_hidden2").val("food_1").click();$("#select_job_hidden3").val("xx09").click();')
end



同时(/^输入产品名称和招商政策$/) do
  $driver.find_element(:id,'product_name').send_keys('测试产品')
  #招商政策是iframe
  $driver.switch_to.frame($driver.find_element(:xpath,'//*[@id="form1"]/div/div[2]/div[14]/div[2]/div[2]/iframe'))
  $driver.find_element(:class,'ke-content').send_keys("呵呵呵呵，这个是招商政策")
  $driver.switch_to.default_content
end



同时(/^选择区域人群和渠道$/) do
  $driver.find_element(:id,'da_').click
  $driver.find_element(:id,'dq_1').click
  $driver.find_element(:id,'ms_1').click
end



同时(/^设置试用$/) do
  #下拉列表选择试用
  $driver.find_element(:id,'is_try').find_elements(:tag_name, 'option')[1].click()
  #维护试用参数
  $driver.find_element(:id,'fee').send_keys('1')
  $driver.find_element(:id,'post_fee').send_keys('2')
  $driver.find_element(:id,'num').send_keys('100')
  $driver.find_element(:id,'report').find_elements(:tag_name, 'option')[0].click()
end


=begin

同时(/^上传产品图片和产品详情$/) do
  img_path = File.dirname(__FILE__) + '/../../image/pass.png'
  exe_path = File.dirname(__FILE__) + '/../../vendor/uploadfile.exe'
  puts "打开上传图片弹窗"
  $driver.find_element(:id,'KindEditor_SWFUpload_2').click
  puts "调用AutoIt可执行程序操作上传文件"
  system exe_path
  sleep 1

  puts "打开上传详情弹窗"
  $driver.find_element(:id,'KindEditor_SWFUpload_3').click
  puts "调用AutoIt可执行程序操作上传文件"
  system exe_path
  sleep 1
end

=end

同时(/^上传产品图片和产品详情$/) do
  @driver = Upload_file.new($driver)
  @driver.upload('propic')
  @driver.upload('prodetpic')
end

并且(/^点击发布产品$/) do
  sleep 2
  $driver.find_element(:xpath,'//*[@id="form1"]/div/div[2]/div[15]/input[4]').click
end


当(/^提示发布产品成功$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  puts "弹窗提示：" + $driver.find_element(:class,'ui_dialog').text
  if /发布成功/ =~ $driver.find_element(:class,'ui_dialog').text then
    @addstat = true
  else
    @addstat = false
  end
end

=begin


并且(/^跳转至厂家产品列表页$/) do
  #判断是否注册成功
  if @addstat then
    puts @addstat
    puts "发布成功"
  else
    puts "发布失败"
  end

  #正则表达式判断跳转页面是否正常
  sleep 5
  if /toProductMngList.do?page/ =~ $driver.current_url then
    puts "页面正确跳转"
    puts "跳转页面的Title为：#{$driver.title}"
    puts "跳转页面的URL为：#{$driver.current_url}"
    @addstat1 = true
  else
    puts  "页面未正确跳转"
    @addstat1 = false
  end
end

那么(/^发布产品功能正常$/) do
  if @addstat and @addstat1 then
    puts "发布产品功能正常"
  else
    puts "发布产品功能异常"
  end
  $driver.quit
end

=end
