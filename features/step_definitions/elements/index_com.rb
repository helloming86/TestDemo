# eloginncoding=utf-8
require 'selenium-webdriver'

module Index_Com

    #获取微信二维码
    def get_Weixin
      @dr.find_element(:link_text, '微信')
    end

    #获取顶部注册
    def get_TopReg
      @dr.find_element(:class,'eqtop_right').find_element(:link_text,'注册')
    end

    #获取底部注册
    def get_BotReg
      @dr.find_element(:class,'eq_xfzc').find_element(:partial_link_text,'注册')
    end

    #获取搜索
    def get_SoInput
      @dr.find_element(:css,'input[name=keywords]')
    end

    #获取搜索按钮
    def get_SoSubmit
      @dr.find_element(:css,'input[type=button]')
    end

    #获取热门搜索
    def get_HotSo
      @dr.find_element(:class,'eqsearch_xb').find_element(:tag_name,'ul').find_elements(:tag_name,'li')[0]
    end

    #获取中部广告位
    def get_MidAd
      @dr.find_element(:id,'da-thumbs').find_elements(:tag_name,'li')[0]
    end

    #获取产品展示区
    def get_ProShow
      @dr.find_element(:id,'two_main').find_element(:css,'#two_main > div > div.xin_right > div:nth-child(3)')
    end
    #获取最新产品
    def get_ProNewPage
      @dr.find_element(:id,'three2')
    end

    def get_ProDefPage
      @dr.find_element(:id,'three3')
    end

    def get_ProHotist
      @dr.find_element(:id,'two_main').find_element(:css,'#two_main > div > div.xin_right > div:nth-child(3)').find_element(:id,'con_three_1')
    end

    def get_ProNewList
      #@dr.find_element(:id,'two_main').find_element(:css,'#two_main > div > div.xin_right > div:nth-child(3)').find_element(:id,'con_three_2')
      @dr.find_element(:id,'con_three_2')
      #@dr.find_element(:id,'two_main').find_element(:css,'#two_main > div > div.xin_right > div:nth-child(3)')
    end

    def get_ProDefList
      #@dr.find_element(:id,'two_main').find_element(:css,'#two_main > div > div.xin_right > div:nth-child(3)').find_element(:id,'con_three_3')
      @dr.find_element(:id,'con_three_3')
    end

    #获取热门供求
    def get_HotSup
      @dr.find_element(:id,'ulid')
    end

    #获取友情链接
    def get_Link
      #方法一层级定位，先定位到ul，在定位li
      #@dr.find_element(:id,'two_foot').find_element(:css,'#two_foot > div > div.twofoot_left > div.eq_link > div.eqlink_nr > ul').find_element(:link_text,'新浪')
      #方法二，直接按照超链定位
      #@dr.find_element(:link_text,'新浪')
      #方法三，多元素随机取值
      #@dr.find_element(:id,'two_foot').find_element(:css,'#two_foot > div > div.twofoot_left > div.eq_link > div.eqlink_nr > ul').find_elements(:tag_name,'li')[0]
      @dr.find_element(:link_text,'百度')
    end



end
