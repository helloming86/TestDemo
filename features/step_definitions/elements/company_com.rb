# eloginncoding=utf-8
require 'selenium-webdriver'

module Company_Com

    # 用户名输入框
    def get_ComName
      @dr.find_element(:css,'input[name=name]')
    end
    #密码输入框
    def get_ComAddr
      @dr.find_element(:css,'input[name=companyAddress]')
    end
    #登录按钮
    def get_ComTel
      @dr.find_element(:css,'input[name=companyTel]')
    end

    def get_ComIntro1
      @dr.find_element(:xpath,'//*[@id="two_main"]/div/div/div/div[7]/div[2]/div[2]/iframe')
    end

    def get_ComBrand
      @dr.find_element(:css,'input[name=brandName]')
    end

    def get_ComProvince
      @dr.find_element(:name,'province').find_elements(:tag_name, 'option')[1]
    end

    def get_ComCity
      @dr.find_element(:name,'city').find_elements(:tag_name, 'option')[1]
    end

    def get_ComArea
      @dr.find_element(:name,'area').find_elements(:tag_name, 'option')[1]
    end

    def get_ComMain
      @dr.find_element(:id,'dq_1')
    end

    def get_RegUpBtn
      @dr.find_element(:css, 'input[type=submit]')
    end

end
