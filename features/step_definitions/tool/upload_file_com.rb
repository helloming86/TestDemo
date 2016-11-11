#encoding=utf-8
require 'selenium-webdriver'

module Upload_file_Com
  #上传logo
  def get_Logo
    @dr.find_element(:id,'KindEditor_SWFUpload_1')
  end
  #上传资质证书
  def get_Honor
    @dr.find_element(:id,'KindEditor_SWFUpload_0')
  end
  #上传产品图片
  def get_ProPic
    @dr.find_element(:id,'KindEditor_SWFUpload_2')
  end
  #上传产品详情
  def get_ProDetail
    @dr.find_element(:id,'KindEditor_SWFUpload_3')
  end

  def autoit_do
    exe_path = File.dirname(__FILE__) + '/../../../vendor/uploadfile.exe'
    system exe_path
  end

end
