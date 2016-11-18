# encoding=utf-8
require 'selenium-webdriver'
require 'mysql2'


class Check_AuthCode

  def initialize(dr)
    # 当@dr不存在时，将dr赋值给@dr
    @dr ||= dr
  end

  def checkauthcode
    wait = Selenium::WebDriver::Wait.new(timeout: 5)
    wait.until do
      @dr.find_element(:class,'ui_dialog').displayed?
    end
    if /^验证码发送成功！$/ =~ @dr.find_element(:class,'ui_dialog').text then
      #读取配置文件数据库参数
      client = Mysql2::Client.new(:host => TTENV["testdb"]["host"], :username => TTENV["testdb"]["username"],:password => TTENV["testdb"]["password"],:database => TTENV["testdb"]["database"],:port => TTENV["testdb"]["port"])
      results = client.query("SELECT code FROM t_sms_record where mobile = '#{DT["testuser"]["phone"]}' ORDER BY date DESC LIMIT 1")

      if results.count == 0 then
        puts "未查询到验证码"
      else
        rcode = Hash.new
        results.each do |rc|
            rcode = rc
        end
      end
    else
      puts  "验证码获取失败"
      puts  "失败原因：" + @dr.find_element(:class,'ui_dialog').text
    end
    dlinfo = @dr.find_element(:class,'ui_dialog').text
    regcode = rcode['code']
    return regcode
  end
end


class Check_Dialog

  def initialize(dr)
    # 当@dr不存在时，将dr赋值给@dr
    @dr ||= dr
  end

  def checkdialog(textinfo)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until do
      @dr.find_element(:class,'ui_dialog').displayed?
    end
    unless textinfo == ''
      puts "校验信息：#{textinfo}"
      puts "弹窗提示：" + @dr.find_element(:class,'ui_dialog').text
      if /#{textinfo}/ =~ @dr.find_element(:class,'ui_dialog').text then
        checkstat = true
        puts "弹窗提示与校验信息匹配，测试通过"
      else
        checkstat = false
        puts "弹窗提示与校验信息不匹配，测试不通过"
      end
      puts checkstat
      return checkstat
    end
  end
end

class Check_PageJump

  def initialize(dr)
    # 当@dr不存在时，将dr赋值给@dr
    @dr ||= dr
  end

  def checkpagejump(textinfo)
    puts "校验信息为(" + textinfo + ")"
    puts "刚执行校验页面跳转方法的页面(" + @dr.current_url + ")"
    sleep 5
    puts "等待5秒后的页面(" + @dr.current_url + ")"
    if textinfo == @dr.current_url then
      puts "页面正确跳转"
      puts "跳转页面的Title为：#{@dr.title}"
      puts "跳转页面的URL为：#{@dr.current_url}"
      checkpage = true
    else
      puts  "页面未正确跳转"
      checkpage = false
    end
    puts checkpage
    return checkpage
  end
end
