# encoding=utf-8
require 'selenium-webdriver'

module Upload_file_Com
    # 上传logo
    def get_Logo
        @dr.find_element(:id, 'KindEditor_SWFUpload_1')
    end

    # 上传资质证书
    def get_Honor
        @dr.find_element(:id, 'KindEditor_SWFUpload_0')
    end

    # 上传产品图片
    def get_ProPic
        @dr.find_element(:id, 'KindEditor_SWFUpload_2')
    end

    # 上传产品详情
    def get_ProDetail
        @dr.find_element(:id, 'KindEditor_SWFUpload_3')
    end

    def autoit_do
        sleep 2
        exe_path = File.dirname(__FILE__) + '/../../../vendor/uploadfile.exe'
        system exe_path
    end
end


=begin

同时(/^上传产品图片和产品详情$/) do
  img_path = File.dirname(__FILE__) + '/../../image/pass.png'
  exe_path = File.dirname(__FILE__) + '/../../vendor/uploadfile.exe'
  puts "打开上传图片弹窗"
  $driver.find_element(:id,'KindEditor_SWFUpload_2').click
  puts "调用AutoIt可执行程序操作上传文件"
  system exe_path
  sleep 1

  puts "打开上传详情弹窗"
  $driver.find_element(:id,'KindEditor_SWFUpload_3').click
  puts "调用AutoIt可执行程序操作上传文件"
  system exe_path
  sleep 1
end

=end
