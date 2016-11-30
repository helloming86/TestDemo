# encregoding=utf-8
require 'selenium-webdriver'
require File.dirname(__FILE__) + '/../elements/index_com.rb'


class Index_Page

  #引用Module
  include Index_Com

  def initialize(dr)
      # 当@dr不存在时，将dr赋值给@dr
      @dr ||= dr
  end

  def testQcCode
    @dr.action.move_to(get_Weixin).perform()
    wait = Selenium::WebDriver::Wait.new(timeout: 5)
    wait.until do
      @dr.find_element(:class,'nav_submenu').displayed?
    end
    if @dr.find_element(:class,'nav_submenu').displayed?
      return true
    else
      return false
    end
  end

  def testTopReg
    get_TopReg.click
  end

  def testBotReg
    get_BotReg.click
  end

  def testSo1
    get_SoInput.send_keys("测试")
    sleep 2
    get_SoSubmit.click
    sleep 2
  end

  def testSo2
    get_HotSo.click
  end

  def testMidAd
    #操作前位置
    puts "操作前hot_info的位置信息如下"
    puts @dr.find_element(:class,'hot_info').location
    puts @dr.find_element(:class,'hot_info').location.x
    puts @dr.find_element(:class,'hot_info').location.y
    puts "操作前广告位的位置信息如下"
    puts get_MidAd.location
    puts get_MidAd.location.x
    puts get_MidAd.location.y

    #鼠标移动至广告位
    @dr.action.move_to(get_MidAd).perform()

    #操作后位置
    puts "操作后hot_info的位置信息如下"
    puts @dr.find_element(:class,'hot_info').location
    puts @dr.find_element(:class,'hot_info').location.x
    puts @dr.find_element(:class,'hot_info').location.y
    puts "操作后广告位的位置信息如下"
    puts get_MidAd.location
    puts get_MidAd.location.x
    puts get_MidAd.location.y

    puts @dr.find_element(:class,'hot_info').displayed?
    wait = Selenium::WebDriver::Wait.new(timeout: 5)
    wait.until do
      @dr.find_element(:class,'hot_info').displayed?
    end
    if @dr.find_element(:class,'hot_info').displayed?
      return true
    else
      return false
    end
  end

  def testProShow
    sleep 1
    #默认最热产品，最新产品不显示
    unless get_ProNewList.displayed?
      puts "默认展示的是最热产品，最新产品div不显示"
    end
    #切换至最新产品，看能否定位到最新产品的div
    get_ProNewPage.click
    wait = Selenium::WebDriver::Wait.new(timeout: 5)
    wait.until do
      get_ProNewList.displayed?
    end
    if get_ProNewList.displayed? then
      puts "点击最新产品分页后定位到最新产品div"
      return true
    else
      puts "点击最新产品分页后未定位到最新产品div"
      return false
    end
  end

  def testHotSupply
    sleep 2
    @dr.action.move_to(get_HotSup).perform()
    sleep 1
    get_HotSup.find_elements(:tag_name,'li')[0].click
    sleep 2
  end

  def testFriendLink

    #执行JS脚本，移动到页面底部，否则不能正确点击超链
    @dr.execute_script('document.body.scrollTop=100000')
    sleep 5
    get_Link.click

  end

end
