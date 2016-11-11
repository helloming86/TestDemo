#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'
require 'mysql2'
require 'yaml'

#读取文件，加载环境参数
ttenv = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/testenv.yaml'))
#加载测试数据，用户信息
dt = YAML.load(File.open(File.dirname(__FILE__) + '/../../config/dt.yaml'))

puts "hahahaha"

假如(/^打开发布供需页面$/) do
  #打开浏览器
  $driver = Selenium::WebDriver.for :chrome
  #打开网址，准备塞入cookie，此步骤不可少，否则，无法塞入cookie
  $driver.get ttenv["testurl"]["loginurl"]
  $driver.manage.window.maximize
  $driver.manage.all_cookies
  $driver.manage.delete_all_cookies
  $driver.manage.add_cookie(name: 'JSESSIONID', value: 'B6FAD9F346FA88667129C13968668004')
  $driver.manage.add_cookie(name: 'username', value: '17811111112')
  $driver.manage.add_cookie(name: 'pwd', value: '8758F78AFCAFC134978E05D6AE679479')
  sleep 2
  #打开发布产品页面
  $driver.get ttenv["testurl"]["addsupplyurl"]
end

同时(/^选择信息类别和产品类别$/) do
  #选择下拉列表
  $driver.find_element(:tag_name, 'select').find_elements(:tag_name, 'option')[1].click()
  #执行js
  #$driver.execute_script('$("#select_job").val("休闲食品").click();')
  $driver.execute_script('$("#select_job").val("休闲食品").click();$("#select_job_hidden").val("kje2bd38-b495-4764-b3eb-946ee8e10645").click();$("#sub_box_job").get(0).style.display="none";')
end

同时(/^输入标题$/) do
  $driver.find_element(:name,'title').send_keys('测试法功供需')
end

同时(/^选择需求区域人群和渠道$/) do
  $driver.find_element(:id,'da_1').click
  $driver.find_element(:id,'dq_1').click
  $driver.find_element(:id,'ms_1').click
end

同时(/^输入需求描述$/) do
  #需求描述是iframe
  $driver.switch_to.frame($driver.find_element(:xpath,'//*[@id="bigForm"]/div[7]/div[2]/div/div[2]/iframe'))
  $driver.find_element(:class,'ke-content').send_keys("呵呵呵呵，这个是需求详情")
  $driver.switch_to.default_content
end

同时(/^输入联系人信息$/) do
  $driver.find_element(:name,'pName').send_keys('发布人名字')
  $driver.find_element(:name,'pAdd').send_keys('发布人地址')
  $driver.find_element(:name,'pCont').send_keys('17811111112')
  $driver.find_element(:name,'pTel').send_keys('17811111112')
  $driver.find_element(:name,'qQq').send_keys('17811111112')
  $driver.find_element(:name,'pMail').send_keys('17811111112@qtcem.com')
end


并且(/^点击提交需求$/) do
  sleep 2
  #方法一，xpath
  #$driver.find_element(:xpath,'//*[@id="bigForm"]/div[11]/input[1]').click
  #方法一，定位元素，直接click
  #$driver.find_element(:class,'Res_btn').click
  #方法三,在已经定位的元素上执行js
  #btn = $driver.find_element(:css, 'input[type=button]')
  btn = $driver.find_element(:class,'Res_btn')
  $driver.execute_script('subSup();',btn)
end

当(/^提示发布需求成功$/) do
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until do
    $driver.find_element(:class,'ui_dialog').displayed?
  end
  puts "弹窗提示：" + $driver.find_element(:class,'ui_dialog').text
  if /发布成功/ =~ $driver.find_element(:class,'ui_dialog').text then
    @addsdstat = true
  else
    @addsdstat = false
  end
end

并且(/^跳转至供求列表页$/) do
  #判断是否注册成功
  if @addsdstat then
    puts @addsdstat
    puts "发布成功"
  else
    puts "发布失败"
  end

  #正则表达式判断跳转页面是否正常
  sleep 5
  if /supply_demands.html/ =~ $driver.current_url then
    puts "页面正确跳转"
    puts "跳转页面的Title为：#{$driver.title}"
    puts "跳转页面的URL为：#{$driver.current_url}"
    @addsdstat1 = true
  else
    puts  "页面未正确跳转"
    @addsdstat1 = false
  end
end

那么(/^发布产品功能正常$/) do
  if @addsdstat and @addsdstat1 then
    puts "发布供求功能正常"
  else
    puts "发布供求功能异常"
  end
  $driver.quit
end
