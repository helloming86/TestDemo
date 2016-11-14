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
end
