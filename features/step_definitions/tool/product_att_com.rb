# encoding=utf-8
require 'selenium-webdriver'

module Product_Att_Com
    # 产品模板,取免费模板
    def get_ProTemp
      @dr.find_element(:name,'templeteNum').find_elements(:tag_name,'option')[1]
    end
    #产品名称
    def get_ProName
      @dr.find_element(:id,'product_name')
    end
    #产品类别
    def get_ProItem
      @dr.find_element(:id,'select_job')
    end
    #招商区域
    def get_ProArea
      @dr.find_element(:id,'da_')
    end
    #目标人群
    def get_ProCrowd
      @dr.find_element(:id,'dq_1')
    end
    #渠道
    def get_ProChannel
      @dr.find_element(:id,'ms_1')
    end
    #产品图片和产品详情是图片，包含在上传类中
    #选择是否试用，0不可试用，1可使用
    def get_ProTry(trytype)
      @dr.find_element(:id,'is_try').find_elements(:tag_name,'option')[trytype]
    end
    #试用参数
    def get_ProTryfee
        @dr.find_element(:id,'fee')
    end
    def get_ProTrypost
        @dr.find_element(:id,'post_fee')
    end
    def get_ProTrynum
        @dr.find_element(:id,'num')
    end
    def get_ProTryfee
        @dr.find_element(:id,'report').find_elements(:tag_name, 'option')[0]
    end
    #招商政策iframe,因为没有id和name，所以用xpath定位
    def get_ProPolicy
      @dr.find_element(:xpath,'//*[@id="form1"]/div/div[2]/div[14]/div[2]/div[2]/iframe')
    end
end
