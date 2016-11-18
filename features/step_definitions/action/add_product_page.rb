# encoding=utf-8
require 'selenium-webdriver'

require File.dirname(__FILE__) + '/../tool/product_att_com.rb'
require File.dirname(__FILE__)+'/upload_file.rb'

class Add_Product_Page
    # 引用module
    include Product_Att_Com

    def initialize(dr)
        # 当@dr不存在时，将dr赋值给@dr
        @dr ||= dr
    end

    def addProduct(trytype)

      #选择产品模板
      get_ProTemp.click
      #设置产品名称
      get_ProName.send_keys('测试新增产品')

      #选择产品类别,三级分类
        #点击分类，显示下拉菜单
      get_ProItem.click
        #等待下拉菜单出现
      wait = Selenium::WebDriver::Wait.new(timeout: 10)
      wait.until do
        @dr.find_element(:id,'sub_box_job').displayed?
      end
        #对下拉菜单进行层级定位，定位到休闲食品，并移动鼠标到休闲食品
      @dr.action.move_to(@dr.find_element(:id,'sub_box_job').find_element(:css, '#sub_box_job > dl:nth-child(1) > dd > ul > li:nth-child(1)')).perform()
        #三级菜单进行层级定位，至儿童饼干并选择
      @dr.find_element(:id,'sub_box_job').find_element(:css,'#sub_box_job > dl:nth-child(1) > dd > ul > li:nth-child(1) > ul > li:nth-child(1)').click

      #选择区域
      get_ProArea.click
      #选择人群
      get_ProCrowd.click
      #选择渠道
      get_ProChannel.click
      #设置试用，0表示不试用，1表示试用
      get_ProTry(trytype).click
      if trytype == '可'
        get_ProTryfee.send_keys('1')
        get_ProTrypost.send_keys('2')
        get_ProTrynum.send_keys('100')
        get_ProTryreport.click

      end
      #上传图片
      @dr1 = Upload_file.new(@dr)
      @dr1.upload('propic')
      @dr1.upload('prodetpic')

      #设置招商政策
      @dr.switch_to.frame(get_ProPolicy)
      @dr.find_element(:class,'ke-content').send_keys("呵呵呵呵，这个是招商政策")
      @dr.switch_to.default_content
      #点击发布
      get_ProAddBut.click

    end

    def prevProdcut
      #点击预览
      get_proPreBut.click
    end

    def get_Message
      puts "弹窗信息"
    end

    def get_Ajax
      puts "Ajax信息"
    end
end
