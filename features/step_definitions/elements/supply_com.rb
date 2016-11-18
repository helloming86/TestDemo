# encoding=utf-8
require 'selenium-webdriver'

module Supply_Com
    # 供求类型
    def get_InfoType
      @dr.find_element(:name,'infoType').find_elements(:tag_name,'option')[1]
    end
    #供求标题
    def get_SupTitle
      @dr.find_element(:name,'title')
    end
    #产品类别
    def get_ProItem1
      @dr.find_element(:id,'select_job')
    end
    #区域
    def get_ProArea1
      @dr.find_element(:id,'da_1')
    end
    #人群
    def get_ProCrowd1
      @dr.find_element(:id,'dq_1')
    end
    #渠道
    def get_ProChannel1
      @dr.find_element(:id,'ms_1')
    end
    #供求详情,使用的iframe
    def get_SupDetail
      @dr.find_element(:xpath,'//*[@id="bigForm"]/div[7]/div[2]/div/div[2]/iframe')
    end
    #发布人姓名
    def getUname
      @dr.find_element(:name,'pName')
    end
    #发布人地址
    def getUadd
      @dr.find_element(:name,'pAdd')
    end
    #发布人联系方式
    def getUcont
      @dr.find_element(:name,'pCont')
    end
    #发布人电话
    def getUtel
      @dr.find_element(:name,'pTel')
    end
    #发布人QQ
    def getUqq
      @dr.find_element(:name,'qQq')
    end
    #发布人Email
    def getUmail
      @dr.find_element(:name,'pMail')
    end
    #提交按钮
    def get_SupBtn1
      @dr.find_element(:class,'Res_btn')
    end
    #取消按钮
    def get_SupBtn2
      @dr.find_element(:class,'Res_btn01 Res_btn')
    end

end
