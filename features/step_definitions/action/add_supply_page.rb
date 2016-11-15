# encoding=utf-8
require 'watir'
require 'selenium-webdriver'

require File.dirname(__FILE__) + '/../tool/supply_com.rb'

class Add_Supply_Page
    # 引用module
    include Supply_Com

    def initialize(dr)
        # 当@dr不存在时，将dr赋值给@dr
        @dr ||= dr
    end

    def addsupply

      #选择类别
      get_InfoType.select '#1'

      #维护Title
      get_SupTitle.set('测试新增供需')

      #设置产品类别
      get_ProItem1.click
      # 间接实现选择分类后关闭分类弹窗
      get_SupTitle.click

      #选择区域
      get_ProArea1.click

      #选择人群
      get_ProCrowd1.click

      #选择渠道
      get_ProChannel1.click

      #维护详情
      get_SupDetail.send_keys('测试新增供需的详情')

      #维护发布人信息
      getUname.set('发布人名字')
      getUadd.set('发布人地址')
      getUcont.set('17811111112')
      getUtel.set('17811111112')
      getUqq.set('17811111112')
      getUmail.set('17811111112@qtcem.com')

      #点击发布
      get_SupBtn1.click

    end

    def cancleAddSupply
      #点击取消
      get_SupBtn2.click
    end

    def get_Message
      puts "弹窗信息"
    end

    def get_Ajax
      puts "Ajax信息"
    end

end
