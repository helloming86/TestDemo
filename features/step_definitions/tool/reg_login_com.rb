# eloginncoding=utf-8
require 'selenium-webdriver'

module Reg_Login_Com

    # 用户名输入框
    def get_LoginName
      @dr.find_element(:id,'loginName')
    end
    #密码输入框
    def get_LoginPwd
      @dr.find_element(:id,'loginPwd')
    end
    #登录按钮
    def get_LoginBtn
      @dr.find_element(:id,'loginSubmit')
    end

    def get_RegPhone
      @dr.find_element(:id,'phone')
    end

    def get_RegPwd
      @dr.find_element(:id,'password')
    end

    def get_RegType(regtype)
      #0表示厂家，1表示经销商
      if regtype == 0
        @dr.find_element(:class,'guide_c').find_element(:id,'three1')
      else
        @dr.find_element(:class,'guide_c').find_element(:id,'three2')
      end
    end

    def get_RegCode
      @dr.find_element(:id,'getcheckCode')
    end

    def get_EnterCode
      @dr.find_element(:id,'code')
    end

    def get_RegBtn
      @dr.find_element(:id,'submit1')
    end


end
