# encregoding=utf-8
require 'selenium-webdriver'
require File.dirname(__FILE__) + '/../tool/reg_login_com.rb'
require File.dirname(__FILE__)+'/check_method.rb'



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

end


class User_Reg_Page
  #引用Module
  include Reg_Login_Com

  def initialize(dr)
      # 当@dr不存在时，将dr赋值给@dr
      @dr ||= dr
  end

  def regUser

    #输入用户名
    get_RegPhone.send_keys(DT["testuser"]["phone"])
    #输入密码
    get_RegPwd.send_keys(DT["testuser"]["password"])
    #选择用户类型
    get_RegType(0).click
    #获取并输入验证码
    get_RegCode.click
    @dr1 = Check_AuthCode.new(@dr)
    get_EnterCode.send_keys(@dr1.checkauthcode)
    sleep 2
    #点击注册
    get_RegBtn.click
  end

end
