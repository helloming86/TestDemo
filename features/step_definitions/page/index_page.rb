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

  def testFriendLink

    #执行JS脚本，移动到页面底部，否则不能正确点击超链
    @dr.execute_script('document.body.scrollTop=100000')
    sleep 5
    get_Link.click

  end

  def testHotSupply

    sleep 2
    @dr.action.move_to(get_HotSup).perform()
    sleep 1
    get_HotSup.find_elements(:tag_name,'li')[0].click
    sleep 2

  end

end
