# language: zh-CN

功能: 注册功能
    验证注册功能是否正常

  场景: 正常注册厂家并完善厂家资料
    假如 打开注册页面
    当 输入手机号和密码
    同时 选择我是厂家
    并且 点击获取验证码
    当 提示验证码获取成功后输入验证码
    并且 点击注册账号
    假如 提示注册成功
    那么 注册成功并跳转至厂家资料维护页面
    当 输入公司名称地址电话简介和品牌
    同时 上传logo和证书
    并且 选择地区和主营产品
    那么 点击提交
    当 提示成功
    并且 跳转至成功页面
    那么 注册厂家流程正常
