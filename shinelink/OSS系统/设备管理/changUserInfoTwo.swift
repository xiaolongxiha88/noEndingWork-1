//
//  changUserInfoTwo.swift
//  ShinePhone
//
//  Created by sky on 17/6/19.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class changUserInfoTwo: RootViewController {

    var  userName:NSString!
    var  lableName:NSString!
    var  oldlableValueName:NSString!
    var  typeNum:Int!
    var  textValue1:UITextField!
    var  textValue2:UITextField!
    var  textValue3:UITextField!
    var netDic:NSDictionary!
     var valueArray:NSMutableArray!
    var  snString:NSString!
    var  paramTypeString:NSString!
    var  value1:NSString!
    var  value2:NSString!
     var  pickerView:RootPickerView!
      var button22:UIButton!
        var getAddress:NSString!
      var zoneAddress:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=MainColor
        
        if typeNum==3 {
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

        
        let lable0=UILabel()
        lable0.textColor=UIColor.white
        lable0.textAlignment=NSTextAlignment.center
        lable0.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        lable0.frame=CGRect(x: 10*NOW_SIZE, y: 45*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 30*HEIGHT_SIZE)
        lable0.text=lableName as String?
        self.view.addSubview(lable0)
        
        let W=240*NOW_SIZE
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
    
   
        button22=UIButton()
        button22.frame=CGRect(x: 50*NOW_SIZE, y: 10*HEIGHT_SIZE, width: 220*NOW_SIZE, height:25*HEIGHT_SIZE)
        
        if (getAddress==nil)||(getAddress=="") {
            button22.setTitle("点击获取服务器地址", for: .normal)
        }else{
            button22.setTitle(getAddress as String?, for: .normal)
            zoneAddress=getAddress
        }
        
        button22.setTitleColor(MainColor, for: .normal)
        button22.setTitleColor(UIColor.white, for: .highlighted)
        button22.layer.borderWidth=0.8*HEIGHT_SIZE;
        button22.layer.cornerRadius=12*HEIGHT_SIZE;
        button22.titleLabel?.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
        button22.titleLabel?.adjustsFontSizeToFitWidth=true
        button22.layer.borderColor=MainColor.cgColor;
        button22.isSelected=false
        button22.backgroundColor=UIColor.clear
        button22.addTarget(self, action:#selector(getServerURL), for: .touchUpInside)
        self.view.addSubview(button22)
        
    }
    
    
    func getServerURL(){

        
     let zoneArray=["+1","+2","+3","+4","+5","+6","+7","+8","+9","+10","+11","+12","-1","-2","-3","-4","-5","-6","-7","-8","-9","-10","-11","-12"]
        
        ZJBLStoreShopTypeAlert.show(withTitle: "选择时区", titles: zoneArray as NSArray as! [NSString], selectIndex: {
            (selectIndex)in
            
            self.zoneAddress=zoneArray[selectIndex] as NSString
            self.getAddress=self.zoneAddress
            print("选择11了"+String(describing: selectIndex))
        }, selectValue: {
            (selectValue)in
            print("选择了"+String(describing: selectValue))
            self.button22.setTitle(selectValue, for: .normal)
        }, showCloseButton: true)
        
    }
    
    
    func finishSet(){
        valueArray=["","","","","","",""]
        value1=""
        
        if !(typeNum==0) {
            if (textValue1.text==nil) || (textValue1.text=="") {
                self.showToastView(withTitle: "请输入服务器IP地址")
                return
            }
            value1=textValue1.text as NSString!
        }

        valueArray.replaceObject(at: typeNum, with: value1)

        netDic=["username":snString,"userEmail":valueArray.object(at: 0),"userTimezone":valueArray.object(at: 1),"userLanguage":valueArray.object(at: 2),"userActiveName":valueArray.object(at:3),"userCompanyName":valueArray.object(at: 4),"userPhoneNum":valueArray.object(at: 5),"userEnableResetPass":valueArray.object(at: 6)]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/user/update/info", sucessBlock: {(successBlock)->() in
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
    

    func initAlertView(){
        let alertController = UIAlertController(title: "是否重置密码？", message: nil, preferredStyle:.alert)
        
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
            self.value1="1"
            self.value2=""
            self.paramTypeString="3"
            self.finishSet()
        }
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
        
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
