require 'watir'
require 'selenium-webdriver'
require 'yaml'

class BrowserContainer
  # 当@dr不存在时，将dr赋值给@dr
  def initialize(dr)
    @dr ||= dr
  end
end

class Br_Op < BrowserContainer

  #引用module，读取文件参数
  include Common_ReadFile
  DT = Common_ReadFile.get_testdata
  TTENV = Common_ReadFile.get_testenv

  def visit(utype)
    #utyp，为URL标识
    @dr.cookies.clear
    sleep 2
    case utype
    when 'loginurl'
      @dr.goto TTENV["testurl"]["loginurl"]
    when 'regurl'
      @dr.goto TTENV["testurl"]["regurl"]
    when 'addprocurl'
      @dr.goto TTENV["testurl"]["loginurl"]
      add_Cookies
      @dr.goto TTENV["testurl"]["addprocurl"]
    when 'addsupplyurl'
      @dr.goto TTENV["testurl"]["loginurl"]
      add_Cookies
      @dr.goto TTENV["testurl"]["addsupplyurl"]
    else
      @dr.goto TTENV["testurl"]["srcurl"]
    end
  end

  def add_Cookies
    @dr.cookies.add(:name => 'JSESSIONID', :value => DT["testcookie"]["jssion"], :path => "/", :expires => 10.days.from_now, :secure => true)
    @dr.cookies.add(:name => 'username', :value => DT["testcookie"]["juname"], :path => "/", :expires => 10.days.from_now, :secure => true)
    @dr.cookies.add(:name => 'pwd', :value => DT["testcookie"]["jpwd"], :path => "/", :expires => 10.days.from_now, :secure => true)
    @dr.cookies.to_a
  end

end

module Common_ReadFile
  def Common_ReadFile.get_testenv
    #读取文件，加载环境参数
    YAML.load(File.open(File.dirname(__FILE__) + '/test_data/testenv.yaml'))
  end

  def Common_ReadFile.get_testdata
    #读取文件，加载测试数据
    YAML.load(File.open(File.dirname(__FILE__) + '/test_data/dt.yaml'))
  end
end
