//
//  swiftHeader.swift
//  ShinePhone
//
//  Created by sky on 16/12/9.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

let NOW_SIZE = UIScreen.main.bounds.width/320
let HEIGHT_SIZE = UIScreen.main.bounds.height/560

func COLOR(_R:Float,_G:Float,_B:Float,_A: Float) -> UIColor {
    return   UIColor.init(colorLiteralRed: _R / 255.0, green: _G / 255.0, blue: _B / 255.0, alpha: _A)
}

let MainColor=COLOR(_R: 0, _G: 156, _B: 255, _A: 1)

let OldMainColor=COLOR(_R: 0, _G: 156, _B: 255, _A: 1)

//#define MainColor COLOR(0, 161, 255, 1)
//let OldMainColor=COLOR(_R: 17, _G: 183, _B: 243, _A: 1)


let backgroundGrayColor=COLOR(_R: 242, _G: 242, _B: 242, _A: 1)

let SCREEN_Width=UIScreen.main.bounds.width
let SCREEN_Height=UIScreen.main.bounds.height

let HEAD_URL=UserInfo.default().server

//let OSS_HEAD_URL=UserInfo.default().osSserver

let OSS_HEAD_URL="http://192.168.3.214:8080/ShineOSS"

 let root_rf_sn=NSLocalizedString("RF序列号", comment: "default")
 let root_datalog_sn=NSLocalizedString("datalog sn", comment: "default")
 let root_datalog_checkCode=NSLocalizedString("datalogger checkcode", comment: "default")
let  root_finish = NSLocalizedString("完成", comment: "default")

let  root_caiJiQi = NSLocalizedString("请输入采集器序列号", comment: "default")
let  root_jiaoYanMa = NSLocalizedString("请输入采集器校验码", comment: "default")
let  root_jiaoYanMa_zhengQue = NSLocalizedString("请输入正确采集器校验码", comment: "default")
let  root_shuru_rf_sn = NSLocalizedString("请输入RFStick序列号", comment: "default")
let  root_peizhi_chenggong = NSLocalizedString("配置成功", comment: "default")
let  root_Networking = NSLocalizedString("Networking Timeout", comment: "default")

let  root_dengDai = NSLocalizedString("等待", comment: "default")
let  root_zhengChang = NSLocalizedString("正常", comment: "default")
let  root_cuoWu = NSLocalizedString("故障", comment: "default")
let  root_duanKai = NSLocalizedString("断开", comment: "default")
let  root_xianZhi = NSLocalizedString("闲置", comment: "default")
let  root_chongDian = NSLocalizedString("充电", comment: "default")
let  root_fangDian = NSLocalizedString("放电", comment: "default")


//未翻译

let  root_shebei_soushuo = NSLocalizedString("设备搜索", comment: "default")
let  root_shuru_soushuo_neirong = NSLocalizedString("输入搜索内容", comment: "default")
let  root_dianji_huoqu_fuwuqi = NSLocalizedString("79点击获取服务器地址", comment: "default")     //
let  root_xuanzhe_soushuo_leixing = NSLocalizedString("选择搜索类型", comment: "default")
let  root_yonghuming = NSLocalizedString("用户名", comment: "default")                  //
let  root_dianzhanming = NSLocalizedString("电站名", comment: "default")
let  root_shoujihao = NSLocalizedString("手机号", comment: "default")
let  root_youxiang = NSLocalizedString("邮箱", comment: "default")
let  root_caijiqi = NSLocalizedString("采集器", comment: "default")
let  root_niBianQi = NSLocalizedString("逆变器", comment: "default")   //
let  root_chuNengJi = NSLocalizedString("储能机", comment: "default")    //
let  root_xuanzhe_fuwuqi_dizhi = NSLocalizedString("选择服务器地址", comment: "default")
let  root_dangqian_shebei_leixing = NSLocalizedString("当前搜索类型", comment: "default")
let  root_xunliehao = NSLocalizedString("序列号", comment: "default")
let  root_bieming = NSLocalizedString("别名", comment: "default")
let  root_shuru_soushuo_leixing = NSLocalizedString("请输入搜索类型", comment: "default")
let  root_shuru_fuwuqi_dizhi = NSLocalizedString("请输入服务器地址", comment: "default")
let  root_xuanze_xuliehao_hebieming = NSLocalizedString("请选择序列号或别名", comment: "default")
let  root_chuanjian_shijian = NSLocalizedString("创建时间", comment: "default")
let  root_suoshu_yonghuming = NSLocalizedString("所属用户名", comment: "default")
let  root_meiyou_gengduo_shuju = NSLocalizedString("没有更多数据", comment: "default")
let  root_xiugai_yonghu_xinxi = NSLocalizedString("修改用户信息", comment: "default")
let  root_WO_shiqu = NSLocalizedString("时区", comment: "default")   //
let  root_zhuantai = NSLocalizedString("状态", comment: "default")
let  root_ip_he_duankou = NSLocalizedString("IP和端口", comment: "default")
let  root_leixing = NSLocalizedString("类型", comment: "default")
let  root_suoshu_caijiqi = NSLocalizedString("所属采集器", comment: "default")
let  root_xinghao = NSLocalizedString("型号", comment: "default")    ///
let  root_lixian = NSLocalizedString("离线", comment: "default")
let  root_zaixian = NSLocalizedString("在线", comment: "default")

let  root_daichuli = NSLocalizedString("73待处理", comment: "default")
let  root_chulizhong = NSLocalizedString("74处理中", comment: "default")
let  root_yichuli = NSLocalizedString("75已处理", comment: "default")
let  root_daigengjin = NSLocalizedString("76待跟进", comment: "default")

let  root_zanwu_shuju = NSLocalizedString("暂无数据", comment: "default")

//"请输入搜索类型"





















//获取String长度
//let attributes1:NSDictionary = NSDictionary(object:UIFont.systemFont(ofSize: 16*HEIGHT_SIZE),
//                                            forKey: NSFontAttributeName as NSCopying)
//let size1=lable3String.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 30*HEIGHT_SIZE), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes1 as? [String : AnyObject], context: nil)

