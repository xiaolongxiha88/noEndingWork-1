//
//  RfStickSwift.swift
//  ShinePhone
//
//  Created by sky on 16/12/7.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit


class RfStickSwift: RootViewController {

    var RfSnLable:UILabel!
    var RfSnText:UITextField!
    var RfSnText1:UITextField!
    var RfSnText2:UITextField!
    var RfGetButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.intUI()
       // self.getNet()
    }

    func intUI() {
        
       
        self.view.backgroundColor=MainColor
        
        let heigh0=40*HEIGHT_SIZE
        let lableArray=[root_datalog_sn,root_datalog_checkCode,root_rf_sn]
        
        for i in 0...2 {
            RfSnLable=UILabel()
            self.RfSnLable.frame=CGRect(x: 10*NOW_SIZE, y: 20*HEIGHT_SIZE+heigh0*CGFloat(i), width: 135*NOW_SIZE, height: 30*HEIGHT_SIZE)
            RfSnLable.text=lableArray[i]
            RfSnLable.textColor=UIColor.white
            RfSnLable.textAlignment=NSTextAlignment.right
            RfSnLable.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            self.view.addSubview(RfSnLable)
        }
        
            RfSnText=UITextField()
            self.RfSnText.frame=CGRect(x: 150*NOW_SIZE, y: 20*HEIGHT_SIZE+heigh0*CGFloat(0), width: 160*NOW_SIZE, height: 30*HEIGHT_SIZE)
            RfSnText.textAlignment=NSTextAlignment.left
            RfSnText.textColor=UIColor.white
            RfSnText.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            RfSnText.layer.borderWidth=0.8;
            RfSnText.layer.cornerRadius=5;
            RfSnText.layer.borderColor=UIColor.white.cgColor;
            self.view.addSubview(RfSnText)
        
        RfSnText1=UITextField()
        self.RfSnText1.frame=CGRect(x: 150*NOW_SIZE, y: 20*HEIGHT_SIZE+heigh0*CGFloat(1), width: 160*NOW_SIZE, height: 30*HEIGHT_SIZE)
        RfSnText1.textAlignment=NSTextAlignment.left
        RfSnText1.textColor=UIColor.white
        RfSnText1.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        RfSnText1.layer.borderWidth=0.8;
        RfSnText1.layer.cornerRadius=5;
        RfSnText1.layer.borderColor=UIColor.white.cgColor;
        self.view.addSubview(RfSnText1)
        
        RfSnText2=UITextField()
        self.RfSnText2.frame=CGRect(x: 150*NOW_SIZE, y: 20*HEIGHT_SIZE+heigh0*CGFloat(2), width: 160*NOW_SIZE, height: 30*HEIGHT_SIZE)
        RfSnText2.textAlignment=NSTextAlignment.left
        RfSnText2.textColor=UIColor.white
        RfSnText2.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        RfSnText2.layer.borderWidth=0.8;
        RfSnText2.layer.cornerRadius=5;
        RfSnText2.layer.borderColor=UIColor.white.cgColor;
        self.view.addSubview(RfSnText2)
        
        RfGetButton=UIButton()
        RfGetButton.frame=CGRect(x: 60*NOW_SIZE, y: 20*HEIGHT_SIZE+heigh0*CGFloat(4), width: 200*NOW_SIZE, height: 40*HEIGHT_SIZE)
        RfGetButton.setBackgroundImage(UIImage(named: "按钮2.png"), for: .normal)
        RfGetButton.setTitle(root_finish, for: .normal)
        RfGetButton.addTarget(self, action:#selector(getNet), for: .touchUpInside)
        self.view.addSubview(RfGetButton)
        
    }
    
    
    
    func getNet() {
          var _:BaseRequest
        
        if RfSnText.text==nil || RfSnText.text!.isEqual(""){
         self.showToastView(withTitle: root_caiJiQi)
            return
        }
        if RfSnText1.text==nil || RfSnText1.text!.isEqual(""){
            self.showToastView(withTitle: root_jiaoYanMa)
            return
        }else{
            if !(RfSnText1.text==BaseRequest.getValidCode(RfSnText.text)){
                self.showToastView(withTitle: root_jiaoYanMa_zhengQue)
                return
            }
        }
        if RfSnText2.text==nil || RfSnText2.text!.isEqual(""){
            self.showToastView(withTitle: root_shuru_rf_sn)
            return
        }
        
      
        let netDic0=["serialNum":RfSnText.text,"rfStickSN":RfSnText2.text]
    
        BaseRequest.request(withMethodResponseStringResult: HEAD_URL, paramars: netDic0, paramarsSite: "/newFtpAPI.do?op=singlepairRFStick", sucessBlock: {(successBlock)->() in
            
          
             let data:Data=successBlock as! Data
        
     let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! NSNumber
                let result=result1.stringValue
                if result.isEqual("1"){
                    self.showToastView(withTitle: root_peizhi_chenggong)
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
