# encregoding=utf-8
require 'selenium-webdriver'
require File.dirname(__FILE__) + '/../tool/reg_login_com.rb'

class User_Login_Page
    # 引用module
    include Reg_Login_Com

    def initialize(dr)
        # 当@dr不存在时，将dr赋值给@dr
        @dr ||= dr
    end

    def login(uinfo)
      #输入用户名
      get_LoginName.send_keys(DT["testuser"]["phone"])
      #输入密码
      if uinfo == '正确'
        get_LoginPwd.send_keys(DT["testuser"]["password"])
      else
        get_LoginPwd.send_keys(DT["testuser"]["password1"])
      end
      #点击登录
      get_LoginBtn.click
    end


    def get_Message
        puts "弹窗信息"
    end

    def get_Ajax
      puts  "Ajax信息"
    end
end
