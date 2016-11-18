require 'selenium-webdriver'
require 'yaml'


class BrowserContainer
  # 当@dr不存在时，将dr赋值给@dr
  def initialize(dr)
    @dr ||= dr
  end
end

class Br_Op < BrowserContainer

  def visit(utype)
    #utyp，为URL标识

    sleep 2
    case utype
    when 'loginurl'
      @dr.get TTENV["testurl"]["loginurl"]
    when 'regurl'
      @dr.get TTENV["testurl"]["regurl"]
    when 'addprocurl'
      @dr.get TTENV["testurl"]["loginurl"]
      add_Cookies
      @dr.get TTENV["testurl"]["addprocurl"]
    when 'addsupplyurl'
      @dr.get TTENV["testurl"]["loginurl"]
      add_Cookies
      @dr.get TTENV["testurl"]["addsupplyurl"]
    else
      @dr.goto TTENV["testurl"]["srcurl"]
    end
  end

  private

  def add_Cookies
    @dr.manage.all_cookies
    @dr.manage.delete_all_cookies
    @dr.manage.add_cookie(name: 'JSESSIONID', value: DT["testcookie"]["jssion"])
    @dr.manage.add_cookie(name: 'username', value: DT["testcookie"]["juname"])
    @dr.manage.add_cookie(name: 'pwd', value: DT["testcookie"]["jpwd"])
  end

end
