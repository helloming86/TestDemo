# encoding=utf-8
require 'selenium-webdriver'

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
    puts "弹窗提示：" + @dr.find_element(:class,'ui_dialog').text
    unless textinfo == ''
      puts "校验信息：#{textinfo}"
      if /#{textinfo}/ =~ @dr.find_element(:class,'ui_dialog').text then
        checkstat = true
      else
        checkstat = false
      end
      if checkstat then
        puts "弹窗提示与校验信息匹配，测试通过"
      else
        puts "弹窗提示与校验信息不匹配，测试不通过"
      end
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

    if /#{textinfo}/ =~ @dr.current_url then
      puts "页面正确跳转"
      puts "跳转页面的Title为：#{@dr.title}"
      puts "跳转页面的URL为：#{@dr.current_url}"
      checkpage = true
    else
      puts  "页面未正确跳转"
      checkpage = false
    end
    return checkpage
  end
end
