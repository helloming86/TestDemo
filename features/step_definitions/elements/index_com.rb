# eloginncoding=utf-8
require 'selenium-webdriver'

module Index_Com

    #获取友情链接
    def get_Link
      #方法一层级定位，先定位到ul，在定位li
      #@dr.find_element(:id,'two_foot').find_element(:css,'#two_foot > div > div.twofoot_left > div.eq_link > div.eqlink_nr > ul').find_element(:link_text,'新浪')
      #方法二，直接按照超链定位
      #@dr.find_element(:link_text,'新浪')
      #方法三，多元素随机取值
      @dr.find_element(:id,'two_foot').find_element(:css,'#two_foot > div > div.twofoot_left > div.eq_link > div.eqlink_nr > ul').find_elements(:tag_name,'li')[0]
    end

    def get_HotSup
      @dr.find_element(:id,'ulid')
    end

end
