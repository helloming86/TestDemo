# encregoding=utf-8
require 'selenium-webdriver'
require 'yaml'
require File.dirname(__FILE__) + '/../tool/reg_login_com.rb'



class User_Login
    # 引用module
    include Reg_Login_Com

    #加载测试数据，用户信息
    @@dt = YAML.load(File.open(File.dirname(__FILE__) + '/../../../config/dt.yaml'))

    def initialize(dr)
        # 当@dr不存在时，将dr赋值给@dr
        @dr ||= dr
    end

    def setLoginName
      get_LoginName.send_keys(@@dt["testuser"]["phone"])
    end

    def setLoginPwd(pwd)
      if pwd == '正确'
        get_LoginPwd.send_keys(@@dt["testuser"]["password"])
      else
        get_LoginPwd.send_keys(@@dt["testuser"]["password1"])
      end
    end

    def do_Login
      get_LoginBtn.click
    end

end
