# encoding=utf-8
require 'selenium-webdriver'
require File.dirname(__FILE__) + '/../tool/product_att_com.rb'

class Add_Product
    # 引用module
    include Product_Att_Com

    def initialize(dr)
        # 当@dr不存在时，将dr赋值给@dr
        @dr ||= dr
    end

    def setProTemp
      get_ProTemp.click
    end
    def setProName
      get_ProName.send_keys('测试新增产品')
    end
    def setProItem
      get_ProItem.click
      @dr.execute_script('$("#select_job").val("休闲食品").click();')
    end
    def setProArea
      get_ProArea.click
    end
    def setProCrowd
      get_ProCrowd.click
    end
    def setProChannel
      get_ProChannel.click
    end

    #试用，0表示不试用，1表示试用
    def setProTry(trytype)
      get_ProTry(trytype).click
      if trytype = 1
        get_ProTryfee.send_keys('1')
        get_ProTrypost.send_keys('2')
        get_ProTrynum.send_keys('100')
        get_ProTryfee.click
      end
    end
    def setProPolicy
      @dr.switch_to.frame(get_ProPolicy)
      @dr.find_element(:class,'ke-content').send_keys("呵呵呵呵，这个是招商政策")
      @dr.switch_to.default_content
    end
end
