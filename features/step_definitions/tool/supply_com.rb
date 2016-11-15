# encoding=utf-8
require 'watir'

module Supply_Com
    # 供求类型
    def get_InfoType
      @dr.select_list(:name => 'infoType')
    end
    #供求标题
    def get_SupTitle
      @dr.text_field(:name => 'title')
    end
    #产品类别
    def get_ProItem1
      @dr.button(:id => 'select_job')
    end
    #区域
    def get_ProArea1
      @dr.link(:id => 'da_',:text => '全部')
    end
    #人群
    def get_ProCrowd1
      @dr.link(:id => 'dq_1',:text => '全部')
    end
    #渠道
    def get_ProChannel1
      @dr.link(:id => 'ms_1',:text => '全部')
    end
    #供求详情,使用的iframe
    def get_SupDetail
      @dr.frame(:class => "ke-edit-iframe")
    end
    #发布人姓名
    def getUname
      @dr.text_field(:name => 'pName')
    end
    #发布人地址
    def getUadd
      @dr.text_field(:name => 'pAdd')
    end
    #发布人联系方式
    def getUcont
      @dr.text_field(:name => 'pCont')
    end
    #发布人电话
    def getUtel
      @dr.text_field(:name => 'pTel')
    end
    #发布人QQ
    def getUqq
      @dr.text_field(:name => 'qQq')
    end
    #发布人Email
    def getUmail
      @dr.text_field(:name => 'pMail')
    end
    #提交按钮
    def get_SupBtn1
      @dr.button(:class => 'Res_btn',:value => '提交')
    end
    #取消按钮
    def get_SupBtn2
      @dr.button(:class => 'Res_btn01 Res_btn',:value => '取消')
    end

end
