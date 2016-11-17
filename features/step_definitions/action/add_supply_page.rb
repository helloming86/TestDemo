# encoding=utf-8
require 'selenium-webdriver'
require 'pp'

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
      get_InfoType.click

      #维护Title
      get_SupTitle.send_keys('测试新增供需')

      #设置产品类别
      get_ProItem1.click
      sleep 2
      # 间接实现选择分类后关闭分类弹窗
      @dr.find_element(:xpath,'//*[@id="sub_box_job"]/dl[1]/dd/ul/li[1]').click
      get_SupTitle.click

      #选择区域
      get_ProArea1.click

      #选择人群
      get_ProCrowd1.click

      #选择渠道
      get_ProChannel1.click

      #维护详情
      @dr.switch_to.frame(get_SupDetail)
      @dr.find_element(:class,'ke-content').send_keys("测试新增供需的详情呵呵呵呵呵呵哈哈哈哈哈哈哈哈哈")
      @dr.switch_to.default_content

      #维护发布人信息
      getUname.send_keys('发布人名字')
      getUadd.send_keys('发布人地址')
      getUcont.send_keys('17811111112')
      getUtel.send_keys('17811111112')
      getUqq.send_keys('17811111112')
      getUmail.send_keys('17811111112@qtcem.com')

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
