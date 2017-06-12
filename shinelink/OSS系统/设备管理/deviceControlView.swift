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
     var imageValue1Array:NSArray!
     var imageNameArray:NSArray!
    var typeNum:NSString!
      var valueDic:NSDictionary!
    var deviceSnString:NSString!
    var deviceTypeString:NSString!
       var dataloggerTypeString:Int!
      var pageNum:Int!
       var netDic:NSDictionary!
      var valueAllDic:NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageNum=0
        typeNum=deviceTypeString
        self.initNet0()
        
    }

    func initData(){
             var status=""
        if (valueDic["lost"] as! Bool){
            status="掉线"}else{status="在线"}
        
        if typeNum=="0"{
         lableNameArray=["序列号","别名","设备类型","用户名","连接状态","IP及端口号","固件版本","服务器IP地址","更新时间","创建日期"]
                let paramBean=valueDic["paramBean"] as! Dictionary<String, Any>
            var version=""
       
            if paramBean.count>0 {
                version=paramBean["firmwareVersionBuild"] as! String
            }
            lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["deviceType"]as! NSString,valueDic["userName"]as! NSString,status,valueDic["clientUrl"]as! NSString,version,valueDic["tcpServerIp"] as! NSString,valueDic["lastUpdateTimeText"] as! NSString,valueDic["createDate"] as! NSString]
        }else if typeNum=="1"{
        lableNameArray=["序列号","别名","所属采集器","连接状态","额定功率(W)","当前功率(W)","今日发电(kWh)","累计发电量(kWh)","逆变器型号","最后更新时间"]
               lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["dataLogSn"]as! NSString,status,valueDic["nominalPower"]as! Float,valueDic["power"]as! Float,valueDic["eToday"]as! Float,valueDic["eTotal"]as! Float,valueDic["modelText"]as! NSString,valueDic["lastUpdateTimeText"] as! NSString]
            
        }else if typeNum=="2"{
            var type=""
            if (valueDic["deviceType"] as! Int)==0{
                type="SP2000"}else if (valueDic["deviceType"] as! Int)==1{type="SP3000"}else if (valueDic["deviceType"] as! Int)==2{type="SPF5000"}
            
            lableNameArray=["序列号","别名","所属采集器","连接状态","充电功率(W)","放电功率(W)","储能机版本","服务器IP地址","储能机型号","最后更新时间"]
               lableValueArray=[valueDic["serialNum"]as! NSString,valueDic["alias"]as! NSString,valueDic["dataLogSn"]as! NSString,status,valueDic["pCharge"]as! Float,valueDic["pDischarge"]as! Float,valueDic["fwVersion"]as! NSString,type,valueDic["tcpServerIp"] as! NSString,type,valueDic["lastUpdateTimeText"] as! NSString]
        }
        
        self.initUI()
        self.initUItwo()
    }
    
    
    func initNet0(){
        
        valueAllDic=[:]
         let addressString=UserDefaults.standard.object(forKey: "OssAddress") as! NSString
        
        netDic=["deviceSn":deviceSnString,"deviceType":deviceTypeString,"alias":"","serverAddr":addressString,"page":pageNum]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/device/info", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
          
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/device/info",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    
                    var plantAll:NSArray=[]
                    
                    if self.deviceTypeString=="0"{
                        plantAll=objArray["datalogList"] as! NSArray
                      self.dataloggerTypeString=(plantAll[0]as! NSDictionary)["deviceTypeIndicate"] as! Int
                        
                    }
                    if self.deviceTypeString=="1"{
                        plantAll=objArray["invList"] as! NSArray
                    }
                    if self.deviceTypeString=="2"{
                         plantAll=objArray["storageList"] as! NSArray
                    }
                    
                       self.valueDic=plantAll[0] as! NSDictionary
                    
                    if self.valueDic.count>0{
                    self.initData()
                    }
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
    func initUI(){
    let Num=lableNameArray.count/2
            let Num1=lableValueArray.count/2
        let H=CGFloat(50)
        
        for i in 0..<Num {
            for k in 0...1 {
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 0*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                let T=(k+2*i)
                lable0.text=lableNameArray[T] as? String
                self.view.addSubview(lable0)
            }
        }
      //  (_R: 153, _G: 153, _B: 153, _A: 1)
        for i in 0..<Num1 {
            for k in 0...1 {
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 20*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                let T=(k+2*i)
                lable0.text=lableValueArray[T] as? String
                let textString=lableValueArray[T] as? String
                if textString==nil || textString=="" {
                     lable0.text="没有数据"
                      lable0.textColor=COLOR (_R: 153, _G: 153, _B: 153, _A: 1)
                }
                
                self.view.addSubview(lable0)
            }
            
        let  view0=UIView()
            view0.frame=CGRect(x: 0*NOW_SIZE, y: 44*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width: SCREEN_Width, height: 1.5*HEIGHT_SIZE)
            view0.backgroundColor=backgroundGrayColor
            self.view.addSubview(view0)
            
        }
        
        let  view2=UIView()
        view2.frame=CGRect(x: 0*NOW_SIZE, y: 44*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(4)), width: SCREEN_Width, height: 10*HEIGHT_SIZE)
        view2.backgroundColor=backgroundGrayColor
        self.view.addSubview(view2)
        
        let  view1=UIView()
        view1.frame=CGRect(x: SCREEN_Width/2-1*NOW_SIZE, y: 0, width: 1.5*NOW_SIZE, height: 255*HEIGHT_SIZE)
        view1.backgroundColor=backgroundGrayColor
        self.view.addSubview(view1)
        
    }
    
    
    func initUItwo(){
    

        if deviceTypeString=="1" || deviceTypeString=="2"{
            imageValueArray=["set_nor.png","edit_nor.png","delete_nor.png"]
            imageValue1Array=["set_click.png","edit_click.png","delete_click.png"]
               imageNameArray=["设置","编辑","删除"]
        }

        if deviceTypeString=="0" {
            if dataloggerTypeString==2 || dataloggerTypeString==6 || dataloggerTypeString==9{
                imageValueArray=["set_nor.png","edit_nor.png","delete_nor.png","configure_nor.png"]
                imageValue1Array=["set_click.png","edit_click.png","delete_click.png","configure_click.png"]
                imageNameArray=["设置","编辑","删除","配置"]
            }else{
                imageValueArray=["set_nor.png","edit_nor.png","delete_nor.png"]
                imageValue1Array=["set_click.png","edit_click.png","delete_click.png"]
                imageNameArray=["设置","编辑","删除"]
            }
            
        }
      let Num0=imageValueArray.count%2
        
         let Num1=imageValueArray.count/2+Num0
         let H=CGFloat(110)
        let imageW=70*HEIGHT_SIZE
        for i in 0..<Num1 {
            for k in 0...1 {
                if Num0==1 {
                    if (i==1)&&(k==1) {
                        break
                    }
                }
                let button2=UIButton()
                button2.frame=CGRect(x: (160*NOW_SIZE-imageW)/2+160*NOW_SIZE*CGFloat(k), y: 270*HEIGHT_SIZE+H*HEIGHT_SIZE*CGFloat(Float(i)), width:imageW, height: imageW)
                let T=(k+2*i)
                button2.tag=2000+T
               button2.setImage(UIImage(named: imageValueArray[T] as! String), for:.normal)
                 button2.setImage(UIImage(named: imageValue1Array[T] as! String), for:.highlighted)
        
                     button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
                self.view.addSubview(button2)
                
                let lable0=UILabel()
                lable0.textColor=COLOR(_R: 153, _G: 153, _B: 153, _A: 1)
                lable0.textAlignment=NSTextAlignment.center
                lable0.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                lable0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(Float(k)), y: 270*HEIGHT_SIZE+imageW+H*HEIGHT_SIZE*CGFloat(Float(i)), width: 160*NOW_SIZE, height: 20*HEIGHT_SIZE)
                lable0.text=imageNameArray[T] as? String
                self.view.addSubview(lable0)
                
            }
            
        }
        
        let  view2=UIView()
        view2.frame=CGRect(x: 0*NOW_SIZE, y:  370*HEIGHT_SIZE, width: SCREEN_Width, height: 1.5*HEIGHT_SIZE)
        view2.backgroundColor=backgroundGrayColor
        self.view.addSubview(view2)

        let  view1=UIView()
        view1.frame=CGRect(x: SCREEN_Width/2-1*NOW_SIZE, y:270*HEIGHT_SIZE, width: 1.5*NOW_SIZE, height: 210*HEIGHT_SIZE)
        view1.backgroundColor=backgroundGrayColor
        self.view.addSubview(view1)
        
        let  view3=UIView()
        view3.frame=CGRect(x: 0*NOW_SIZE, y:  view1.frame.origin.y+view1.frame.size.height, width: SCREEN_Width, height: SCREEN_Height-view1.frame.origin.y-view1.frame.size.height)
        view3.backgroundColor=backgroundGrayColor
        self.view.addSubview(view3)
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
        
        
//        if CELL=="1"{
//            let goView=deviceControlView()
//            self.navigationController?.pushViewController(goView, animated: true)
//        }else if CELL=="2"{
//            let goView=kongZhiNi0()
//            goView.controlType="2"
//            self.navigationController?.pushViewController(goView, animated: true)
//        }else if CELL=="3"{
//            let goView=controlCNJTable()
//            goView.controlType="2"
//            self.navigationController?.pushViewController(goView, animated: true)
//        }
        
        
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
