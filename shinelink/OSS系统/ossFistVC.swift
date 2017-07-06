//
//  ossFistVC.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossFistVC: RootViewController {

     var imageOne:UIImageView!
       var buttonOne:UIButton!
       var buttonTwo:UIButton!
       var buttonThree:UIButton!
      var messageView:UIView!
        var serverListArray:NSArray!
    var serverNumArray:NSArray!
    var orderNumArray:NSArray!
       var integratorValueArray:NSArray!
    
 var newInfoType:Int!
     var infoID:Int!
      var infoAddress:NSString!
     var infoString:NSString!
    
     var roleString:NSString!
    
    let heigh0=96*NOW_SIZE
    
    override func viewDidLoad() {
        super.viewDidLoad()

//  [self.navigationController.navigationBar setBarTintColor:MainColor];
        self.navigationController?.navigationBar.barTintColor=MainColor
        self.navigationItem.hidesBackButton=true
        
        self.title="OSS系统"
        
        self.navigationItem.backBarButtonItem?.title="";
        
   self.navigationController?.setNavigationBarHidden(false, animated: false)

        let leftItem=UIBarButtonItem.init(title: "退出账户", style: .plain, target: self, action:#selector(resisgerName) )
          self.navigationItem.leftBarButtonItem=leftItem
        
           roleString=UserDefaults.standard.object(forKey: "roleNum") as! NSString!
        
        serverNumArray=[0,0]
        orderNumArray=[0,0]
        infoString=""
        
     
        
       self.initUI()
        
   
        if roleString=="2" || roleString=="0" || roleString=="1"{
               self.initNet0()
        }else if roleString=="5"{
            self.initNet1()
            
        }

        
       
    }

    
    func initUI(){
    
        imageOne=UIImageView()
        self.imageOne.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: heigh0)
         imageOne.image=UIImage(named: "title_bg.png")
        self.view.addSubview(imageOne)
        
    }
    
    
    func initUIThree(){
      
        let view1=UIView()
        view1.frame=CGRect(x: 0*NOW_SIZE, y: heigh0+10*HEIGHT_SIZE, width: SCREEN_Width, height: 40*HEIGHT_SIZE)
        view1.backgroundColor=UIColor.clear
        view1.isUserInteractionEnabled=true
        let tap0=UITapGestureRecognizer(target: self, action: #selector(gotoDevice))
        view1.addGestureRecognizer(tap0)
         self.view.addSubview(view1)
        
        let imageH=20*HEIGHT_SIZE
        let imageV = UIImageView()
        imageV.frame=CGRect(x: 10*NOW_SIZE, y: (40*HEIGHT_SIZE-imageH)/2, width: imageH, height: imageH)
        imageV.image=UIImage(named: "device_iconI.png")
        view1.addSubview(imageV)
        
        let  lable1=UILabel()
        lable1.frame=CGRect(x: 10*NOW_SIZE+imageH+10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 40*HEIGHT_SIZE)
        lable1.text="设备管理"
        lable1.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
        lable1.textAlignment=NSTextAlignment.left
        lable1.font=UIFont.systemFont(ofSize: 18*HEIGHT_SIZE)
        view1.addSubview(lable1)
        
        let imageH2=20*HEIGHT_SIZE
        let imageV2 = UIImageView()
        imageV2.frame=CGRect(x: (SCREEN_Width-20*NOW_SIZE)-imageH2, y: (40*HEIGHT_SIZE-imageH2)/2, width: imageH2, height: imageH2)
        imageV2.image=UIImage(named: "firstGo.png")
        view1.addSubview(imageV2)

        let imageAll = UIImageView()
        imageAll.frame=CGRect(x: 5*NOW_SIZE, y:heigh0+55*HEIGHT_SIZE, width: SCREEN_Width-10*NOW_SIZE, height: 180*HEIGHT_SIZE)
        imageAll.image=UIImage(named: "frameIntergrator.png")
         self.view.addSubview(imageAll)
        
        for i in 0...1 {
            for K in 0...1 {
                
                let viewW=155*NOW_SIZE
                 let viewH=90*HEIGHT_SIZE
                let viewA=UIView()
                viewA.frame=CGRect(x:0*NOW_SIZE+viewW*CGFloat(i), y:0+viewH*CGFloat(K), width:viewW, height: viewH)
                viewA.backgroundColor=UIColor.clear
                imageAll.addSubview(viewA)
                
                let imagePH=40*HEIGHT_SIZE
                let H=(viewH-imagePH)/2
                 let W=10*NOW_SIZE
                let imageP = UIImageView()
                imageP.frame=CGRect(x: W, y: H, width: imagePH, height: imagePH)
                viewA.addSubview(imageP)
                
                let  lable1=UILabel()
                lable1.frame=CGRect(x: W*2+imagePH, y: H-5*HEIGHT_SIZE, width: viewW-(W*2+imagePH), height: 40*HEIGHT_SIZE)
               
                lable1.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable1.textAlignment=NSTextAlignment.left
                   lable1.adjustsFontSizeToFitWidth=true
                lable1.font=UIFont.systemFont(ofSize: 24*HEIGHT_SIZE)
                viewA.addSubview(lable1)
                
                let  lable2=UILabel()
                lable2.frame=CGRect(x: W*2+imagePH, y: H-17*HEIGHT_SIZE+40*HEIGHT_SIZE, width: viewW-(W*2+imagePH), height: 20*HEIGHT_SIZE)
               
                lable2.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                lable2.textAlignment=NSTextAlignment.left
                lable2.adjustsFontSizeToFitWidth=true
                lable2.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
                viewA.addSubview(lable2)
           
                // self.integratorValueArray=[objDic["todayEnergy"] as? Int ?? 0,objDic["totalEnergy"] as? Int ?? 0,objDic["totalInvNum"] as? Int ?? 0,objDic["totalPower"] as? Int ?? 0];
                if i==0 {
                    if K==0 {
                          imageP.image=UIImage(named: "e-today_iconI.png")
                         lable1.text=self.integratorValueArray[0] as? String
                         lable2.text="今日发电量(kWh)"
                    }
                    if K==1 {
                        imageP.image=UIImage(named: "inv_iconI.png")
                           lable1.text=self.integratorValueArray[2] as? String
                         lable2.text="逆变器总数(台)"
                    }
                }
                if i==1 {
                    if K==0 {
                        imageP.image=UIImage(named: "etotaliconI.png")
                          lable1.text=self.integratorValueArray[1] as? String
                          lable2.text="累计发电量(kWh)"
                    }
                    if K==1 {
                        imageP.image=UIImage(named: "power_iconI.png")
                           lable1.text=self.integratorValueArray[3] as? String
                        lable2.text="装机功率(W)"
                    }
                }
              
                
                
                
            }
        }
        
        
    }
    
    func initUItwo(){
     
        buttonOne=UIButton()
        buttonOne.frame=CGRect(x: 10*NOW_SIZE, y: heigh0+10*HEIGHT_SIZE, width: 300*NOW_SIZE, height:heigh0)
        buttonOne.setBackgroundImage(UIImage(named: "gongdan_bg.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        buttonOne.addTarget(self, action:#selector(gotoDevice), for: .touchUpInside)
        self.view.addSubview(buttonOne)
        
   
        let AllH=160*HEIGHT_SIZE;
        for i in 0...1 {
            let viewAll=UIView()
            viewAll.frame=CGRect(x: 0*NOW_SIZE, y: (heigh0+10*HEIGHT_SIZE)*2+(AllH+5*HEIGHT_SIZE)*CGFloat(i), width: SCREEN_Width, height: AllH)
            viewAll.backgroundColor=UIColor.clear
            self.view.addSubview(viewAll)
            
            let view1=UIView()
            view1.frame=CGRect(x: 0*NOW_SIZE, y: 0, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
            view1.backgroundColor=UIColor.clear
            view1.isUserInteractionEnabled=true
            view1.tag=2000+i
            let tap0=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
                view1.addGestureRecognizer(tap0)
            viewAll.addSubview(view1)
            
            let imageH=20*HEIGHT_SIZE
            let imageV = UIImageView()
            imageV.frame=CGRect(x: 10*NOW_SIZE, y: (30*HEIGHT_SIZE-imageH)/2, width: imageH, height: imageH)
            imageV.image=UIImage(named: "workorderFirst.png")
            if i==0 {
                 imageV.image=UIImage(named: "Customer.png")
            }
         
            view1.addSubview(imageV)
            
            let  lable1=UILabel()
            lable1.frame=CGRect(x: 10*NOW_SIZE+imageH+10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 30*HEIGHT_SIZE)
            lable1.text="客服系统"
            if i==1 {
             lable1.text="工单系统"
            }
            lable1.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            lable1.textAlignment=NSTextAlignment.left
            lable1.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
            view1.addSubview(lable1)
            
            let imageH2=20*HEIGHT_SIZE
            let imageV2 = UIImageView()
            imageV2.frame=CGRect(x: (SCREEN_Width-20*NOW_SIZE)-imageH2, y: (30*HEIGHT_SIZE-imageH2)/2, width: imageH2, height: imageH2)
            imageV2.image=UIImage(named: "firstGo.png")
            view1.addSubview(imageV2)
            if i==0 {

                let view2=UIView()
                view2.frame=CGRect(x: 0*NOW_SIZE, y: 35*HEIGHT_SIZE, width: SCREEN_Width, height: 40*HEIGHT_SIZE)
                view2.backgroundColor=UIColor.clear
                view2.isUserInteractionEnabled=true
                let tap=UITapGestureRecognizer(target: self, action: #selector(goToNew))
                view2.addGestureRecognizer(tap)
                
                viewAll.addSubview(view2)
                
                let bundleDBPath:String? = Bundle.main.path(forResource: "message_icon2", ofType: "gif")
                let data1=NSData.init(contentsOfFile:bundleDBPath!)
                let gifWebH2=20*HEIGHT_SIZE
                
                let gifWeb=UIWebView()
                gifWeb.frame=CGRect(x: 10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: gifWebH2, height: gifWebH2*1.2)
                gifWeb.load(data1! as Data, mimeType:"image/gif", textEncodingName: String(), baseURL:NSURL() as URL)
                gifWeb.isUserInteractionEnabled=false
                gifWeb.scalesPageToFit=true
                gifWeb.isOpaque=false
                gifWeb.backgroundColor=UIColor.clear
                
                if (((UserDefaults.standard.object(forKey: "newInfoEnble")  as AnyObject).isEqual(NSNull.init())) == false){
                    let newInfoEnble=UserDefaults.standard.object(forKey: "newInfoEnble") as! Bool
                    if newInfoEnble {
                        view2.addSubview(gifWeb)
                    }
                }else{
                 view2.addSubview(gifWeb)
                }
                
              
                
                
                let  lable2=UILabel()
                lable2.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 250*NOW_SIZE, height: 20*HEIGHT_SIZE)
                lable2.text="最新接收消息"
                lable2.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
                lable2.textAlignment=NSTextAlignment.left
                lable2.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
                view2.addSubview(lable2)
                
                let image4H=5*HEIGHT_SIZE
                let  image4=UIImageView()
                image4.layer.masksToBounds=true
                image4.layer.cornerRadius=image4H/2
                image4.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE, y: 20*HEIGHT_SIZE+(20*HEIGHT_SIZE-image4H)/2, width: image4H, height: image4H)
                if (((UserDefaults.standard.object(forKey: "newInfoEnble")  as AnyObject).isEqual(NSNull.init())) == false){
                    let newInfoEnble=UserDefaults.standard.object(forKey: "newInfoEnble") as! Bool
                    if newInfoEnble {
                        image4.backgroundColor=UIColor.red
                    }else{
                        image4.backgroundColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                    }
                }else{
                  image4.backgroundColor=UIColor.red
                }
             
              
                view2.addSubview(image4)
                
                let  lable3=UILabel()
                lable3.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE+image4H+5*NOW_SIZE, y: 20*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
                lable3.text=infoString! as String
                lable3.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
                lable3.textAlignment=NSTextAlignment.left
                lable3.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
                view2.addSubview(lable3)
                
            }
 
            
            
            let viewLine=UIView()
            if i==0 {
                 viewLine.frame=CGRect(x: 0*NOW_SIZE, y: 80*HEIGHT_SIZE, width: SCREEN_Width, height: 1*HEIGHT_SIZE)
            }else{
               viewLine.frame=CGRect(x: 0*NOW_SIZE, y: 35*HEIGHT_SIZE, width: SCREEN_Width, height: 1*HEIGHT_SIZE)
            }
           
            viewLine.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLine)
            
            let viewButtonH=80*HEIGHT_SIZE
            
            let viewLineCenter=UIView()
            viewLineCenter.frame=CGRect(x: SCREEN_Width/2, y: viewLine.frame.origin.y, width: 1*NOW_SIZE, height: viewButtonH)
            viewLineCenter.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLineCenter)
            
            let viewButton=UIView()
            viewButton.frame=CGRect(x: 0*NOW_SIZE, y: viewLine.frame.origin.y+1*HEIGHT_SIZE, width: SCREEN_Width/2, height: viewButtonH)
            viewButton.backgroundColor=UIColor.clear
            viewButton.isUserInteractionEnabled=true
            viewButton.tag=3000+i
            let tap2=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
            viewButton.addGestureRecognizer(tap2)
            
            viewAll.addSubview(viewButton)
            
            let ButtonImageH=40*HEIGHT_SIZE
            let ButtonImag = UIImageView()
            ButtonImag.frame=CGRect(x: (SCREEN_Width/4-ButtonImageH/2), y: 10*HEIGHT_SIZE, width: ButtonImageH, height: ButtonImageH)
            ButtonImag.image=UIImage(named: "Follow-up2.png")
            if i==1 {
                 ButtonImag.image=UIImage(named: "follow-up.png")
            }
            viewButton.addSubview(ButtonImag)
            
            let  ButtonLable2=UILabel()
            ButtonLable2.frame=CGRect(x:0, y: 15*HEIGHT_SIZE+ButtonImageH, width: SCREEN_Width/2, height: 20*HEIGHT_SIZE)
             ButtonLable2.text=String(format: "%@:%d", "待跟进",(serverNumArray[0] as? Int)!)
            if i==1 {
               ButtonLable2.text=String(format: "%@:%d", "待接收",(orderNumArray[0] as? Int)!)
            }
            ButtonLable2.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            ButtonLable2.textAlignment=NSTextAlignment.center
            ButtonLable2.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            viewButton.addSubview(ButtonLable2)
            
            let viewButton1=UIView()
            viewButton1.frame=CGRect(x: SCREEN_Width/2, y: viewLine.frame.origin.y+1*HEIGHT_SIZE, width: SCREEN_Width/2, height: viewButtonH)
            viewButton1.backgroundColor=UIColor.clear
            viewButton1.isUserInteractionEnabled=true
            viewButton1.tag=4000+i
            let tap3=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
            viewButton1.addGestureRecognizer(tap3)
            viewAll.addSubview(viewButton1)
            
            
            let ButtonImag1 = UIImageView()
            ButtonImag1.frame=CGRect(x: (SCREEN_Width/4-ButtonImageH/2), y: 10*HEIGHT_SIZE, width: ButtonImageH, height: ButtonImageH)
           
            if i==1 {
                ButtonImag1.image=UIImage(named: "Untreated1111.png")
            }
            if i==0{
             ButtonImag1.image=UIImage(named: "Untreated22.png")
            }
            viewButton1.addSubview(ButtonImag1)
            
            let  ButtonLable21=UILabel()
            ButtonLable21.frame=CGRect(x:0, y: 15*HEIGHT_SIZE+ButtonImageH, width: SCREEN_Width/2, height: 20*HEIGHT_SIZE)
         
            ButtonLable21.text=String(format: "%@:%d", "未处理",serverNumArray[1] as! Int)
            if i==1 {
                ButtonLable21.text=String(format: "%@:%d", "服务中",orderNumArray[1] as! Int)
            }
            ButtonLable21.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            ButtonLable21.textAlignment=NSTextAlignment.center
            ButtonLable21.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            viewButton1.addSubview(ButtonLable21)
            
            let viewLine1=UIView()
            viewLine1.frame=CGRect(x: 0*NOW_SIZE, y: viewLine.frame.origin.y+1*HEIGHT_SIZE+viewButtonH, width: SCREEN_Width, height: 1*HEIGHT_SIZE)
            viewLine1.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLine1)

        }
        
    }
    
    
    func goToNew(){
    UserDefaults.standard.set(false, forKey: "newInfoEnble")
        
        if  newInfoType==1 {
            let vc=ossQuetionDetail()
            let id=NSString(format: "%d", infoID)
            vc.qusetionId=id as String!
            vc.serverUrl=infoAddress! as String
            self.navigationController?.pushViewController(vc, animated: true)
        }else  if  newInfoType==2 {
            let vc=orderFirst()
            let id=NSString(format: "%d", infoID)
            vc.orderID=id as String!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func initNet0(){
        
 
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:[:], paramarsSite: "/api/v1/serviceQuestion/question/service_overview_data", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/info=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objDic=jsonDate["obj"] as! NSDictionary
                    self.serverNumArray=[objDic["waitFollowNum"] as! Int,objDic["notProcessedNum"] as! Int]
                    self.orderNumArray=[objDic["waitReceiveNum"] as! Int,objDic["inServiceNum"] as! Int]
                
    
                    if (((objDic["ticketSystemBean"]  as AnyObject).isEqual(NSNull.init())) == false){
                        
                        let ticketSystemBeanDic=objDic["ticketSystemBean"] as! NSDictionary
                        self.newInfoType=2
                        if ticketSystemBeanDic.count>0{
                            self.infoID=ticketSystemBeanDic["id"] as! Int
                              self.infoString=NSString(format: "%@",ticketSystemBeanDic["title"] as! NSString )
                        }
                       
                    }
                    
                    if (((objDic["replyBean"]  as AnyObject).isEqual(NSNull.init())) == false){
                        let replyBeanDic=objDic["replyBean"] as! NSDictionary
                        if replyBeanDic.count>0{
                            self.newInfoType=1
                            self.infoID=replyBeanDic["questionId"] as! Int
                            self.infoAddress=replyBeanDic["serverUrl"] as! NSString
                            self.infoString=NSString(format: "%@:%@",replyBeanDic["userName"] as! NSString,replyBeanDic["message"] as! NSString )
                        }
                    }
                   
                    if (((UserDefaults.standard.object(forKey: "newInfoEnble")  as AnyObject).isEqual(NSNull.init())) == false){
                        let newInfo=UserDefaults.standard.object(forKey: "newInfo") as! NSString
                        if newInfo != self.infoString{
                            UserDefaults.standard.set(self.infoString, forKey: "newInfo")
                            UserDefaults.standard.set(true, forKey: "newInfoEnble")
                        }
                    }else{
                        UserDefaults.standard.set(self.infoString, forKey: "newInfo")
                        UserDefaults.standard.set(true, forKey: "newInfoEnble")
                    }
                    
                   
                          self.initUItwo()
                    
                }else{
                         self.initUItwo()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
             self.initUItwo()
               self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
   
    func initNet1(){
        
             integratorValueArray=[0,0,0,0];
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:[:], paramarsSite: "/api/v1/customer/customer_overview_data", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/customer/customer_overview_data=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objDic=jsonDate["obj"] as! NSDictionary
                    
                    if objDic.count>0{
                        self.integratorValueArray=[objDic["todayEnergy"] as? String ?? "",objDic["totalEnergy"] as? String ?? "",objDic["totalInvNum"] as? String ?? "",objDic["totalPower"] as? String ?? ""];
                    
                                 self.initUIThree()
                    }
                    
       
                    
                }else{
                      self.initUIThree()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.initUIThree()
            self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    
    
    
    func resisgerName(){
    
           let oldName=UserDefaults.standard.object(forKey: "OssName")
            let oldPassword=UserDefaults.standard.object(forKey: "OssPassword")
        
    UserDefaults.standard.set("F", forKey: "LoginType")
            UserDefaults.standard.set("", forKey: "OssName")
      
            UserDefaults.standard.set("", forKey: "OssPassword")
        UserDefaults.standard.set("", forKey: "server")
        
        let vc=loginViewController()
        vc.oldName=oldName as! String!
            vc.oldPassword=oldPassword as! String!
        self.navigationController?.pushViewController(vc, animated: true)
        

        
        
    }
    
    
    func gotoServer(Tap:UITapGestureRecognizer ) {
        
        
        
        let vc=ossServerFirst()
        if Tap.view?.tag==2000 {
               vc.questionOrOrder=1
              vc.statusInt=10
               vc.firstNum=0
            vc.secondNum=0
        }
        if Tap.view?.tag==2001 {
            vc.questionOrOrder=2
            vc.statusInt=0
            vc.firstNum=1
            vc.secondNum=0
        }
        
        if Tap.view?.tag==3000 {
            vc.questionOrOrder=1
            vc.statusInt=3
            vc.secondNum=2
            vc.firstNum=0
        }
        
        if Tap.view?.tag==4000 {
            vc.questionOrOrder=1
            vc.statusInt=0
            vc.secondNum=1
            vc.firstNum=0
        }
        
        if Tap.view?.tag==3001 {
            vc.questionOrOrder=2
            vc.statusInt=2
            vc.secondNum=1
            vc.firstNum=1
        }
        
        if Tap.view?.tag==4001{
            vc.questionOrOrder=2
            vc.statusInt=3
            vc.secondNum=2
            vc.firstNum=1
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoDevice()  {
        
        if roleString=="2" || roleString=="0" || roleString=="1"{
            let vc=ossDeviceFirst()
            vc.serverListArray=self.serverListArray
            self.navigationController?.pushViewController(vc, animated: true)
        }else if roleString=="5"{
            let vc=IntegratorFirst()
              vc.firstNum=0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
          self.showToastView(withTitle:"没有操作权限")
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
