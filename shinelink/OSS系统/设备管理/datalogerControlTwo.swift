//
//  datalogerControlTwo.swift
//  ShinePhone
//
//  Created by sky on 17/5/24.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class datalogerControlTwo: RootViewController {

    var  lableName:NSString!
     var  oldlableValueName:NSString!
    var  typeNum:NSString!
    var  textValue1:UITextField!
        var  textValue2:UITextField!
        var  textValue3:UITextField!
       var netDic:NSDictionary!
    var  snString:NSString!
       var  paramTypeString:NSString!
     var  value1:NSString!
       var  value2:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor=MainColor
        
        if typeNum=="4" {
            self.initUItwo()
        }else{
         self.initUI()
        }
       
        let button2=UIButton(type: .custom)
        button2.frame=CGRect(x:60*NOW_SIZE, y: 180*HEIGHT_SIZE, width:200*NOW_SIZE, height: 40*HEIGHT_SIZE)
        button2.setBackgroundImage(UIImage(named:"按钮2.png" ), for:.normal)
        button2.setTitle(root_finish, for:.normal)
        button2.titleLabel?.textColor=UIColor.white
        button2.tintColor=UIColor.white
        button2.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        button2.addTarget(self, action:#selector(finishSet), for: .touchUpInside)
        self.view.addSubview(button2)
    }

    func initUI(){
//        let lable01=UILabel()
//        lable01.textColor=UIColor.white
//        lable01.textAlignment=NSTextAlignment.center
//        lable01.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
//        lable01.frame=CGRect(x: 10*NOW_SIZE, y: 40*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 30*HEIGHT_SIZE)
//        lable01.text=lableName as String?
//        self.view.addSubview(lable01)
        
        let lable0=UILabel()
        lable0.textColor=UIColor.white
        lable0.textAlignment=NSTextAlignment.center
        lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        lable0.frame=CGRect(x: 10*NOW_SIZE, y: 45*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 30*HEIGHT_SIZE)
        lable0.text=lableName as String?
        self.view.addSubview(lable0)
        
        let W=200*NOW_SIZE
        textValue1=UITextField()
        textValue1.textColor=UIColor.white
        textValue1.textAlignment=NSTextAlignment.center
        textValue1.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue1.frame=CGRect(x: (SCREEN_Width-W)/2, y: 90*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue1.layer.borderWidth=1
         textValue1.layer.cornerRadius=6
         textValue1.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue1)
        
    
        
    }
    
    func initUItwo(){
       let nameArray=["寄存器:","值:"]
        for (i,name) in nameArray.enumerated() {
            
            let lable0=UILabel()
            lable0.textColor=UIColor.white
            lable0.textAlignment=NSTextAlignment.right
            lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
            lable0.frame=CGRect(x: 5*NOW_SIZE, y: 40*HEIGHT_SIZE+50*HEIGHT_SIZE*CGFloat(i), width: 100*NOW_SIZE, height: 30*HEIGHT_SIZE)
            lable0.text=name as String?
            self.view.addSubview(lable0)
            
        }
        
        let W=150*NOW_SIZE
        textValue2=UITextField()
        textValue2.textColor=UIColor.white
        textValue2.textAlignment=NSTextAlignment.left
        textValue2.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue2.frame=CGRect(x: 112*NOW_SIZE, y: 40*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue2.layer.borderWidth=1
        textValue2.layer.cornerRadius=6
        textValue2.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue2)
        
        textValue3=UITextField()
        textValue3.textColor=UIColor.white
        textValue3.textAlignment=NSTextAlignment.left
        textValue3.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        textValue3.frame=CGRect(x: 112*NOW_SIZE, y: 90*HEIGHT_SIZE, width: W, height: 30*HEIGHT_SIZE)
        textValue3.layer.borderWidth=1
        textValue3.layer.cornerRadius=6
        textValue3.layer.borderColor=UIColor.white.cgColor
        self.view.addSubview(textValue3)
        
    }
    
    
    
    
    
    func finishSet(){
        value1=""
        value2=""
        paramTypeString=""
        if typeNum=="0" {
            if (textValue1.text==nil) || (textValue1.text=="") {
                self.showToastView(withTitle: "请输入服务器IP地址")
                return
            }
           paramTypeString="1"
            value1=textValue1.text as NSString!
        }
        if typeNum=="1" {
            if (textValue1.text==nil) || (textValue1.text=="") {
                self.showToastView(withTitle: "请输入服务器域名")
                return
            }
            paramTypeString="2"
            value1=textValue1.text as NSString!
        }
        if typeNum=="4" {
            if (textValue2.text==nil) || (textValue2.text=="") {
                self.showToastView(withTitle: "请输入寄存器地址")
                return
            }
            if (textValue3.text==nil) || (textValue3.text=="") {
                self.showToastView(withTitle: "请输入寄存器设置值")
                return
            }
            paramTypeString="0"
            value1=textValue2.text as NSString!
             value2=textValue3.text as NSString!
        }
        netDic=["datalogSn":snString,"paramType":paramTypeString,"param_1":value1,"param_2":value2]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/deviceSet/set/datalog", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/device/info",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
            
                    self.showToastView(withTitle: "设置成功")
                self.navigationController!.popViewController(animated: true)
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.showToastView(withTitle: root_Networking)
        })

    
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
