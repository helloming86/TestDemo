#encoding=utf-8
require 'selenium-webdriver'
require 'rspec/expectations'

require File.dirname(__FILE__)+'/page/index_page.rb'
require File.dirname(__FILE__)+'/common/br_op.rb'

假如(/^打开首页$/) do
  puts "1"
  @driver = Br_Op.new(@drr)
  puts "2"
  @driver.visit('indexurl')
  #在Chrome浏览器使用navigate会出错
  #@driver.navigate.to "http://www.baidu.com"
  puts "3"
end

当(/^鼠标悬停在微信出现二维码$/) do
  @driver = Index_Page.new(@drr)
  @checkdisplay = @driver.testQcCode
end

那么(/^顶部二维码正常$/) do
  puts @checkdisplay
  if @checkdisplay
    puts "检查点通过验证，顶部二维码正常"
  else
    puts "检查点未通过验证，顶部二维码异常"
  end
end

当(/^点击注册登录页面正确跳转$/) do
  @driver = Index_Page.new(@drr)
  @driver.testTopReg
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump(TTENV["testurl"]["regurl"])
  @driver = Br_Op.new(@drr)
  @driver.visit('indexurl')
end

那么(/^顶部注册登录入口正常$/) do
  puts @checkpage
  if  @checkpage
    puts "检查点通过验证，顶部注册登录入口正常"
  else
    puts "检查点未通过验证，顶部注册登录入口异常"
  end
end

当(/^点击底部浮窗注册登录页面正确跳转$/) do
  @driver = Index_Page.new(@drr)
  @driver.testBotReg
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump(TTENV["testurl"]["regurl"])
  @driver = Br_Op.new(@drr)
  @driver.visit('indexurl')
end

那么(/^底部浮窗注册登录入口正常$/) do
  puts @checkpage
  if  @checkpage
    puts "检查点通过验证，底部注册登录入口正常"
  else
    puts "检查点未通过验证，底部注册登录入口异常"
  end
end

当(/^搜索框输入关键字后页面正常跳转$/) do
  @driver = Index_Page.new(@drr)
  @driver.testSo1

  @driver = Check_PageJump.new(@drr)
  @checkpage1 = @driver.checkpagejump('searchGoods')

  @driver = Br_Op.new(@drr)
  @driver.visit('indexurl')
end

而且(/^点击热门搜索后页面正确跳转$/) do
  @driver = Index_Page.new(@drr)
  @driver.testSo2

  @driver = Check_PageJump.new(@drr)
  @checkpage2 = @driver.checkpagejump('searchGoods')

  @driver = Br_Op.new(@drr)
  @driver.visit('indexurl')

end

那么(/^搜索功能正常$/) do
  puts @checkpage1,@checkpage2
  if @checkpage1 and @checkpage2
    puts "检查点通过验证，搜索功能正常"
  else
    puts "检查点未通过验证，搜索功能异常"
  end
end

当(/^点击主标签产品列表发生变化$/) do
  @driver = Index_Page.new(@drr)
  @checkdisplay = @driver.testProShow
  sleep 2
end

那么(/^标签分类产品展示正常$/) do
  puts @checkdisplay
  if @checkdisplay
    puts "检查点通过验证，标签分类产品展示正常"
  else
    puts "检查点未通过验证，标签分类产品展示异常"
  end
end


当(/^定位到市场供求并且点击页面正确跳转$/) do
  @driver = Index_Page.new(@drr)
  puts "222"
  @driver.testHotSupply
  puts "333"
  @driver = Check_PageJump.new(@drr)
  @checkpage = @driver.checkpagejump('supply_demand')
  puts "444"
  @driver = Br_Op.new(@drr)
  @driver.visit('indexurl')
end

#检查点：
那么(/^市场供求正常$/) do
  puts @checkpage
  if  @checkpage
    puts "检查点通过验证，市场供求正常"
  else
    puts "检查点未通过验证，市场供求异常"
  end
end


当(/^定位到友情链接并且点击页面正常跳转$/) do
  @driver = Index_Page.new(@drr)
  @checkpage = @driver.testFriendLink
end

#检查点：
那么(/^友情链接正常$/) do
  puts @checkpage
  if  @checkpage
    puts "检查点通过验证，友情链接正常"
  else
    puts "检查点未通过验证，友情链接异常"
  end
end
