//
//  deviceControlView.swift
//  ShinePhone
//
//  Created by sky on 17/5/22.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class deviceControlView: RootViewController {

      var lableNameArray:NSArray!
     var lableValueArray:NSArray!
    var imageValueArray:NSArray!
     var imageNameArray:NSArray!
    var typeNum:Int!
      var valueDic:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.initData()
      self.initUI()
        self.initUItwo()
    }

    func initData(){
             var status=""
        if (valueDic["lost"] as! Int)==0{
            status="在线"}else{status="掉线"}
        
        if typeNum==0{
         lableNameArray=["序列号","别名","设备类型","用户名","连接状态","IP及端口号","固件版本","更新时间"]
                let paramBean=valueDic["paramBean"] as! Dictionary<String, Any>
            var version=""
       
            if paramBean.count>0 {
                version=paramBean["firmwareVersionBuild"] as! String
            }
            lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["deviceType"]as! NSString,valueDic["alias"]as! NSString,status,valueDic["alias"]as! NSString,version,valueDic["lastUpdateTimeText"] as! NSString]
        }else if typeNum==1{
        lableNameArray=["序列号","别名","所属采集器","连接状态","额定功率(W)","当前功率(W)","今日发电(kWh)","累计发电量(kWh)","逆变器型号","最后更新时间"]
               lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["dataLogSn"]as! NSString,status,valueDic["nominalPower"]as! NSString,valueDic["power"]as! NSString,valueDic["alias"]as! NSString,valueDic["alias"]as! NSString,valueDic["alias"]as! NSString,valueDic["lastUpdateTimeText"] as! NSString]
            
        }else if typeNum==1{
            var type=""
            if (valueDic["deviceType"] as! Int)==0{
                type="SP2000"}else if (valueDic["deviceType"] as! Int)==1{type="SP3000"}else if (valueDic["deviceType"] as! Int)==2{type="SPF5000"}
            
            lableNameArray=["序列号","别名","所属采集器","连接状态","充电","放电","储能机型号","最后更新时间"]
               lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["dataLogSn"]as! NSString,status,valueDic["alias"]as! NSString,valueDic["alias"]as! NSString,type,valueDic["lastUpdateTimeText"] as! NSString]
        }
        
   
    }
    
    func initUI(){
    let Num=lableNameArray.count/2
            let Num1=lableValueArray.count/2
        let H=CGFloat(60)
        
        for i in 0..<Num {
            for k in 0...1 {
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 153, _G: 153, _B: 153, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 10*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                let T=(k+2*i)
                lable0.text=lableNameArray[T] as? String
                self.view.addSubview(lable0)
            }
        }
        
        for i in 0..<Num1 {
            for k in 0...1 {
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 40*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                let T=(k+2*i)
                lable0.text=lableValueArray[T] as? String
                self.view.addSubview(lable0)
            }
        }
        
    }
    
    
    func initUItwo(){
    
         imageValueArray=["setOSS.png","editOSS.png","deleteOSS.png","peizhiOSS.png"]
         imageNameArray=["设置","编辑","删除","配置"]
         let Num1=imageValueArray.count/2
         let H=CGFloat(90)
        let imageW=50*HEIGHT_SIZE
        for i in 0..<Num1 {
            for k in 0...1 {
                let button2=UIButton()
                button2.frame=CGRect(x: (160*NOW_SIZE-imageW)/2+160*NOW_SIZE*CGFloat(k), y: 270*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width:imageW, height: imageW)
                let T=(k+2*i)
                button2.tag=2000+T
               button2.setImage(UIImage(named: imageValueArray[T] as! String), for:.normal)
                     button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
                self.view.addSubview(button2)
                
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 275*HEIGHT_SIZE+imageW+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                lable0.text=imageNameArray[T] as? String
                self.view.addSubview(lable0)
                
            }
            
        }
        
        
    }
    
    
    func butttonChange(uibutton: UIButton)  {
    
        if uibutton.tag==2000 {
            let goView=datalogerControlView()
            goView.cellNameArray=["设置IP","设置域名","重启采集器","清除采集器记录","高级设置"]
            self.navigationController?.pushViewController(goView, animated: true)
            
        }

        
        if uibutton.tag==2001 {
            let goView=ChangeCellectViewController()
            goView.alias="测试"
            goView.datalogSN="23221333222"
            goView.unitId="1"
            self.navigationController?.pushViewController(goView, animated: true)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
