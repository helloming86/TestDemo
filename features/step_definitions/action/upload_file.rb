#encoding=utf-8
require 'selenium-webdriver'
require File.dirname(__FILE__)+'/../tool/upload_file_com.rb'

class Upload_file
  #引用module
  include Upload_file_Com

  def initialize(dr)
    #当@dr不存在时，将dr赋值给@dr
    @dr ||= dr
  end

  def upload(filetype)
    #打开上传窗口
    case filetype
    when 'logo'
      get_Logo.click
    when 'honor'
      get_Honor.click
    when 'propic'
      get_ProPic.click
    else
      get_ProDetail.click
    end
    #调用并执行AutoIt
    autoit_do
    sleep 1
  end

end
