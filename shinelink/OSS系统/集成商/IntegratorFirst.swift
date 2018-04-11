//
//  IntegratorFirst.swift
//  ShinePhone
//
//  Created by sky on 17/6/2.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class IntegratorFirst: RootViewController {

     var deviceString:NSString!
 
    var view0:UIView!
    var buttonThree:UIButton!
      var view1:UIView!
     var netDic:NSDictionary!
     var valueDic:NSDictionary!
    
       var deviceType:Int!
     var deviceStatusType:Int!
      var accessStatus:Int!
      var agentCodeString:NSString!
     var plantName:NSString!
    var userName:NSString!
      var codeName:NSString!
       var datalogSnString:NSString!
       var agentCompanyArray:NSMutableArray!
     var accountNameArray:NSMutableArray!
    
        var agentCodeArray:NSMutableArray!
     var firstNum:Int!
      var roleString:NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.navigationController?.navigationBar.barTintColor=MainColor
    self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        deviceType=0
        accessStatus=1
        agentCodeString="0"
        plantName = ""
        userName = ""
        datalogSnString = ""
        deviceString = ""
  codeName=""

        
        let tap=UITapGestureRecognizer(target: self, action: #selector(keyboardHide(tap:)))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        
    
        
        roleString=UserDefaults.standard.object(forKey: "roleNum") as? NSString ?? ""
        codeName=UserDefaults.standard.object(forKey: "agentCodeId") as? NSString ?? ""
        
        if roleString=="6" || roleString=="14"{
        self.initNet0()
        }else if roleString=="7" || roleString=="15"{
          self.initNet01()
        }
        
        self.initUI()
        self.initNet1()
        
    }
    
    func keyboardHide(tap:UITapGestureRecognizer){
        for i in 5000..<5004{
        let text=view0.viewWithTag(i)
            text?.resignFirstResponder()
        }
    }

    func initUI() {
        let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=1
        buttonView.goToNetNum=2
         buttonView.firstNum=firstNum
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=["逆变器","储能机"]
        buttonView.initUI()
        self.view .addSubview(buttonView)
        
        let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView2")
        NotificationCenter.default.addObserver(self, selector:#selector(tableViewReload(info:)),
                                               name: NotifyChatMsgRecv, object: nil)
        
        for i in 0...1{
            let view3=UIView()
            view3.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 30*HEIGHT_SIZE, width: 160*NOW_SIZE, height: 40*HEIGHT_SIZE)
            view3.backgroundColor=UIColor.clear
            view3.isUserInteractionEnabled=true
            view3.tag=3000+i
            let tap=UITapGestureRecognizer(target: self, action: #selector(getDevice(tap:)))
            view3.addGestureRecognizer(tap)
            self.view.addSubview(view3)
            
            let Lable1=UILabel()
            Lable1.frame=CGRect(x: 20*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 120*NOW_SIZE, height: 40*HEIGHT_SIZE)
            if i==0 {
                Lable1.text="已接入设备"
            }else if i==1{
                if roleString=="6" || roleString=="14"{
                    Lable1.text="所有代理商"
                }else if roleString=="7" || roleString=="15"{
                    Lable1.text="所有电站"
                }
             
            }
            Lable1.tag=4000+i
            Lable1.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
            Lable1.textAlignment=NSTextAlignment.center
            Lable1.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            view3.addSubview(Lable1)
            
            let image1=UIImageView()
            image1.frame=CGRect(x: 142*NOW_SIZE, y: 18*HEIGHT_SIZE, width: 8*HEIGHT_SIZE, height: 6*HEIGHT_SIZE)
            image1.image=UIImage.init(named:"upOSS.png")
            view3.addSubview(image1)
            
            let view0=UIView()
            view0.frame=CGRect(x: 15*NOW_SIZE, y: 40*HEIGHT_SIZE, width: 140*NOW_SIZE, height: 1*HEIGHT_SIZE)
            view0.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            view3.addSubview(view0)

        
        }
        
        self.initUITwo()
    }
    
    
    func initUITwo() {
        view0=UIView()
        view0.frame=CGRect(x: 0*NOW_SIZE, y: 71*HEIGHT_SIZE, width: SCREEN_Width, height: 125*HEIGHT_SIZE)
        view0.backgroundColor=UIColor.clear
        view0.isUserInteractionEnabled=true
        self.view.addSubview(view0)
        
          let nameArray=["电站名","用户名","采集器序列号","设备序列号"]
        for i in 0...1 {
            for K in 0...1{
              let field0=UITextField()
                field0.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 0*HEIGHT_SIZE+40*HEIGHT_SIZE*CGFloat(K), width: 160*NOW_SIZE, height: 40*HEIGHT_SIZE)
                field0.placeholder=nameArray[i+2*K]
                field0.textAlignment=NSTextAlignment.center
                field0.tag=5000+K*2+i
                if roleString=="7" || roleString=="15"{
                    if i==0 && K==0{
                        field0.text=codeName as String?
                        field0.isUserInteractionEnabled=false
                    }
                }
             
                
                field0.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                field0.tintColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                field0.setValue(COLOR(_R: 154, _G: 154, _B: 154, _A: 1), forKeyPath: "_placeholderLabel.textColor")
                  field0.setValue(UIFont.systemFont(ofSize: 12*HEIGHT_SIZE), forKeyPath: "_placeholderLabel.font")
                field0.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
                view0.addSubview(field0)

                let view1=UIView()
                view1.frame=CGRect(x: 15*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 40*HEIGHT_SIZE+40*HEIGHT_SIZE*CGFloat(K), width: 140*NOW_SIZE, height: 1*HEIGHT_SIZE)
                view1.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
                view0.addSubview(view1)
            
            }
        }
        
        
        buttonThree=UIButton()
        buttonThree.frame=CGRect(x: 60*NOW_SIZE, y:95*HEIGHT_SIZE, width: 200*NOW_SIZE, height:30*HEIGHT_SIZE)
       // buttonThree.backgroundColor=COLOR(_R: 242, _G: 242, _B: 242, _A: 1)
        buttonThree.setTitle("搜索", for: .normal)
        buttonThree.layer.borderWidth=0.8*HEIGHT_SIZE;
        buttonThree.layer.cornerRadius=16*HEIGHT_SIZE;
        buttonThree.titleLabel?.adjustsFontSizeToFitWidth=true
        buttonThree.layer.borderColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1).cgColor;
        buttonThree.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        buttonThree.setTitleColor(COLOR(_R: 102, _G: 102, _B: 102, _A: 1), for: .normal)
        buttonThree.setTitleColor(UIColor.black, for: .highlighted)
        buttonThree.addTarget(self, action:#selector(initNet1), for: .touchUpInside)
        view0.addSubview(buttonThree)

        
        let LableView=UIView()
        LableView.frame=CGRect(x: 0*NOW_SIZE, y: 210*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        LableView.backgroundColor=backgroundGrayColor
        self.view.addSubview(LableView)
        
        let Lable3=UILabel()
        Lable3.frame=CGRect(x: 120*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 80*NOW_SIZE, height: 30*HEIGHT_SIZE)
            Lable3.text="查询结果"
        Lable3.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        Lable3.adjustsFontSizeToFitWidth=true
        Lable3.textAlignment=NSTextAlignment.center
        Lable3.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        LableView.addSubview(Lable3)
        
        let view3=UIView()
        view3.frame=CGRect(x: 65*NOW_SIZE, y: 14*HEIGHT_SIZE, width: 50*NOW_SIZE, height: 1*HEIGHT_SIZE)
        view3.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
        LableView.addSubview(view3)
        
        let view4=UIView()
        view4.frame=CGRect(x: 205*NOW_SIZE, y: 14*HEIGHT_SIZE, width: 50*NOW_SIZE, height: 1*HEIGHT_SIZE)
        view4.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
        LableView.addSubview(view4)
        
      //  self.initUIThree()
    }
    
    
    
    func initUIThree(){
        if (self.view1 != nil){
            self.view1.removeFromSuperview()
            self.view1=nil
        }
        
        view1=UIView()
        view1.frame=CGRect(x: 0*NOW_SIZE, y: 250*HEIGHT_SIZE, width: SCREEN_Width, height: 200*HEIGHT_SIZE)
        view1.backgroundColor=UIColor.clear
        view1.isUserInteractionEnabled=true
        self.view.addSubview(view1)
    
       let view2=UIView()
        view2.frame=CGRect(x: 5*NOW_SIZE, y: 5*HEIGHT_SIZE, width: 310*NOW_SIZE, height: 30*HEIGHT_SIZE)
        view2.backgroundColor=UIColor.clear
        view2.isUserInteractionEnabled=true
        view2.tag=2600
        let tap=UITapGestureRecognizer(target: self, action: #selector(goDetailDevice(tap:)))
        view2.addGestureRecognizer(tap)
       view1.addSubview(view2)
        
        let Lable3=UILabel()
        Lable3.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 310*NOW_SIZE, height: 30*HEIGHT_SIZE)
        
        var lable3Name0 = ""
        let lable3Name1=["全部","已接入","未接入"]
        if deviceType==1 {
            lable3Name0=String(format: "%@储能机总数:", lable3Name1[accessStatus])
        }else{
             lable3Name0=String(format: "%@逆变器总数:", lable3Name1[accessStatus])
        }
        
        let lable3AllString=NSString(format: "%@%d", lable3Name0,valueDic.object(forKey: "totalNum") as? Int ?? 0)
        Lable3.text=lable3AllString as String
        Lable3.textColor=MainColor
        Lable3.textAlignment=NSTextAlignment.center
        Lable3.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
         Lable3.adjustsFontSizeToFitWidth=true
        view2.addSubview(Lable3)
        
        let size1=self.getStringSize(Float(16*HEIGHT_SIZE), wsize: MAXFLOAT, hsize: Float(30*HEIGHT_SIZE), stringName: lable3AllString as String?)

        let image1=UIImageView()
        image1.frame=CGRect(x: (310*NOW_SIZE+size1.width)/2+10*NOW_SIZE, y: 11.5*HEIGHT_SIZE, width: 5*HEIGHT_SIZE, height: 8*HEIGHT_SIZE)
        image1.image=UIImage.init(named:"moreOSS.png")
        view2.addSubview(image1)
        
        var nameArray:NSArray=[]
          var colorArray:NSArray=[]
         var valueArray:NSArray=[]
        if self.deviceType==0{
                nameArray=["在线:","等待:","故障:","离线:"]
              colorArray=[COLOR(_R: 2, _G: 232, _B:2, _A: 1),COLOR(_R: 233, _G: 223, _B:74, _A: 1),COLOR(_R: 238, _G: 73, _B:51, _A: 1),COLOR(_R: 181, _G: 186, _B:189, _A: 1)]
            valueArray=[valueDic.object(forKey: "onlineNum") as? Int ?? 0,valueDic.object(forKey: "waitNum") as? Int ?? 0,valueDic.object(forKey: "faultNum") as? Int ?? 0,valueDic.object(forKey: "offlineNum") as? Int ?? 0]
                    }
        
        if self.deviceType==1{
             colorArray=[COLOR(_R: 2, _G: 232, _B:2, _A: 1),COLOR(_R: 181, _G: 186, _B:189, _A: 1),COLOR(_R: 154, _G: 229, _B:128, _A: 1),COLOR(_R: 222, _G: 211, _B:91, _A: 1),COLOR(_R: 238, _G: 73, _B:51, _A: 1)]
             nameArray=["在线:","离线:","充电:","放电:","故障:"]
                    valueArray=[valueDic.object(forKey: "onlineNum") as? Int ?? 0,valueDic.object(forKey: "offlineNum") as? Int ?? 0,valueDic.object(forKey: "chargeNum") as? Int ?? 0,valueDic.object(forKey: "dischargeNum") as? Int ?? 0,valueDic.object(forKey: "faultNum") as? Int ?? 0]
        }


        let Yu=nameArray.count%2
        let Num=nameArray.count/2
        for i in 0...1 {
            for K in 0..<(Num+Yu){
                if i==1 && Yu==1 && K==(Num+Yu-1) {
                    break
                }
                let view2=UIView()
                view2.frame=CGRect(x: 0*NOW_SIZE+160*NOW_SIZE*CGFloat(i), y: 45*HEIGHT_SIZE+60*HEIGHT_SIZE*CGFloat(K), width: SCREEN_Width/2, height: 40*HEIGHT_SIZE)
                view2.backgroundColor=UIColor.clear
                view2.isUserInteractionEnabled=true
                view2.tag=2500+K*2+i
                let tap=UITapGestureRecognizer(target: self, action: #selector(goDetailDevice(tap:)))
                view2.addGestureRecognizer(tap)
                view1.addSubview(view2)
                
                let Lable3=UILabel()
                Lable3.frame=CGRect(x: 15*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 130*NOW_SIZE, height: 30*HEIGHT_SIZE)
                let lable3String=String(format: "%@%d", nameArray[i+2*K] as? NSString ?? "",valueArray[i+2*K] as? Int ?? 0)
                Lable3.text=lable3String
                Lable3.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                Lable3.textAlignment=NSTextAlignment.center
                Lable3.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
                Lable3.adjustsFontSizeToFitWidth=true
                view2.addSubview(Lable3)
                
                let size1=self.getStringSize(Float(16*HEIGHT_SIZE), wsize: MAXFLOAT, hsize: Float(30*HEIGHT_SIZE), stringName: lable3String)
                
                let image1=UIImageView()
                image1.frame=CGRect(x: (160*NOW_SIZE+size1.width)/2+10*NOW_SIZE, y: 11.5*HEIGHT_SIZE, width: 5*HEIGHT_SIZE, height: 8*HEIGHT_SIZE)
                image1.image=UIImage.init(named:"moreOSS.png")
                view2.addSubview(image1)
                
                let image2=UIImageView()
                image2.frame=CGRect(x: (160*NOW_SIZE-size1.width)/2, y: 30*HEIGHT_SIZE, width:size1.width+10*NOW_SIZE+5*HEIGHT_SIZE, height: 5*HEIGHT_SIZE)
                image2.backgroundColor=colorArray[i+2*K] as? UIColor
                image2.layer.borderWidth=0.2*HEIGHT_SIZE;
                image2.layer.cornerRadius=3*HEIGHT_SIZE;
                image2.layer.borderColor=UIColor.clear.cgColor
                view2.addSubview(image2)
                
            }
        }
        
    }
    
    
    func goDetailDevice(tap:UITapGestureRecognizer){
    let Tag=tap.view?.tag
        
       //   nameArray=["在线:","等待:","故障:","离线:"]
        if self.deviceType==0{
            if Tag==2600{
            deviceStatusType=0
            }else if Tag==2500{
                 deviceStatusType=2
            }else if Tag==2501{
                deviceStatusType=4
            }else if Tag==2502{
                deviceStatusType=3
            }else if Tag==2503{
                deviceStatusType=1
            }
        }
      //  nameArray=["在线:","离线:","充电:","放电:","故障:"]
        if self.deviceType==1{
            if Tag==2600{
                deviceStatusType=0
            }else if Tag==2500{
                deviceStatusType=2
            }else if Tag==2501{
                deviceStatusType=1
            }else if Tag==2502{
                deviceStatusType=4
            }else if Tag==2503{
                deviceStatusType=5
            }else if Tag==2504{
                deviceStatusType=3
            }
        }
        
        let vc=intergratorDeviceList()
        vc.deviceStatusType=self.deviceStatusType
        vc.netDic=self.netDic
     vc.deviceType=self.deviceType
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getDevice(tap:UITapGestureRecognizer){
   let View1=tap.view!
     let A=View1.tag-3000+4000
          let B1 = view.viewWithTag(A) as! UILabel
       
        
        if A==4000 {
             let nameArray=["已接入设备","未接入设备"]
              let valueArray=[1,2]
            ZJBLStoreShopTypeAlert.show(withTitle: "选择设备类型", titles: nameArray as NSArray as! [NSString], selectIndex: {
                (selectIndex)in
                self.accessStatus=valueArray[selectIndex] as Int
                print("选择11了"+String(describing: selectIndex))
            }, selectValue: {
                (selectValue)in
                print("选择了"+String(describing: selectValue))
                B1.text=selectValue
            }, showCloseButton: true)
        }
        
        if A==4001 {
            var titleName:String=""
            if roleString=="6" || roleString=="14"{
               titleName="选择代理商"
            }else if roleString=="7" || roleString=="15"{
                titleName="选择电站"
            }
            ZJBLStoreShopTypeAlert.show(withTitle: titleName, titles: agentCompanyArray as NSArray as! [NSString], selectIndex: {
                (selectIndex)in
   
                if self.roleString=="7" || self.roleString=="15"{
                    let name=self.agentCompanyArray[selectIndex] as? NSString ?? ""
                    if selectIndex != 0{
                        let substringArry =  name.components(separatedBy: ":");
                        //    (self.view0.viewWithTag(5000) as! UITextField).text=substringArry[0] as String
                        (self.view0.viewWithTag(5001) as! UITextField).text = substringArry[0] as String
                        self.plantName=substringArry[1] as NSString
                        self.userName=substringArry[0] as NSString
                    }else{
                        self.plantName=""
                        self.userName=""
                    }
               
                }else{
                self.agentCodeString=self.agentCodeArray[selectIndex] as? NSString ?? ""
                }
                
             
                print("选择11了"+String(describing: selectIndex))
            }, selectValue: {
                (selectValue)in
                print("选择了"+String(describing: selectValue))
                B1.text=selectValue
            }, showCloseButton: true)
        }

        
    }
    
    func tableViewReload(info:NSNotification){
        
        let  dic=info.userInfo as Any as!NSDictionary
        let Tag=dic.object(forKey: "tag") as? Int ?? 0
        if Tag==2000 {
            deviceType=0
           
        }
        if Tag==2001 {
            deviceType=1
        }
 self.initNet1()
    }
    
//MARK: - 网络层
    
    func initNet0(){
    
        agentCodeArray=["0","1"]
        agentCompanyArray=["所有代理商","没有代理商"]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:[:], paramarsSite: "/api/v2/customer/agent_list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/customer/agent_list=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as? Int ?? 0
                
                if result1==1 {
                     let objArray=jsonDate["obj"] as! NSArray
                    for i in 0..<objArray.count{
                        self.agentCodeArray.add((objArray[i] as! NSDictionary)["code"] as? NSString ?? "" )
                        self.agentCompanyArray.add((objArray[i] as! NSDictionary)["company"] as? NSString ?? "")
                        
                    }
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as? String ?? "")
                }
                
            }
            
        }, failure: {(error) in
              self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
    func initNet01(){
        
        agentCodeArray=[""]
        agentCompanyArray=["所有电站"]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:[:], paramarsSite: "/api/v2/customer/plant_list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v2/customer/plant_list=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! NSArray
                    for i in 0..<objArray.count{
                        self.agentCodeArray.add((objArray[i] as! NSDictionary)["plantName"] as? NSString ?? "" )
                        
                        let name=NSString.init(format: "%@:%@", ((objArray[i] as! NSDictionary)["accountName"] as? NSString ?? ""),((objArray[i] as! NSDictionary)["plantName"] as? NSString ?? ""))
                        self.agentCompanyArray.add(name)
                        
                    }
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as? String ?? "")
                }
                
            }
            
        }, failure: {(error) in
            self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    func initNet1(){
        if self.roleString=="7" || self.roleString=="15"{
        agentCodeString=""
            datalogSnString = (view0.viewWithTag(5002) as! UITextField).text as NSString?
            deviceString = (view0.viewWithTag(5003) as! UITextField).text as NSString?
        }else{
            plantName = (view0.viewWithTag(5000) as! UITextField).text as NSString?
            userName = (view0.viewWithTag(5001) as! UITextField).text as NSString?
            datalogSnString = (view0.viewWithTag(5002) as! UITextField).text as NSString?
            deviceString = (view0.viewWithTag(5003) as! UITextField).text as NSString?
        }
        
        netDic=["deviceType":deviceType,"accessStatus":accessStatus,"agentCode":agentCodeString,"plantName":plantName,"userName":userName,"datalogSn":datalogSnString,"deviceSn":deviceString]
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:netDic as! [AnyHashable : Any]?, paramarsSite: "/api/v2/customer/device_num", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v2/customer/device_num=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as? Int ?? 0
                
                if result1==1 {
                  let objDic=jsonDate["obj"] as! Dictionary<String, Any>
                    if self.deviceType==0{
                    self.valueDic=["faultNum":objDic["faultNum"] as? Int ?? 0,"nullNum":objDic["nullNum"] as? Int ?? 0,"offlineNum":objDic["offlineNum"] as? Int ?? 0,"onlineNum":objDic["onlineNum"] as? Int ?? 0,"totalNum":objDic["totalNum"] as? Int ?? 0,"waitNum":objDic["waitNum"] as? Int ?? 0]
                    }
                    if self.deviceType==1{
self.valueDic=["chargeNum":objDic["chargeNum"]as? Int ?? 0,"dischargeNum":objDic["dischargeNum"]as? Int ?? 0,"faultNum":objDic["faultNum"]as? Int ?? 0,"nullNum":objDic["nullNum"]as? Int ?? 0,"offlineNum":objDic["offlineNum"]as? Int ?? 0,"onlineNum":objDic["onlineNum"]as? Int ?? 0,"totalNum":objDic["totalNum"]as? Int ?? 0]
                    }
               
                    
                 self.initUIThree()
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as? String ?? "")
                }
                
            }
            
        }, failure: {(error) in
              self.hideProgressView()
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
