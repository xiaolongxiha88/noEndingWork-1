//
//  ossFistVC.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossFistVC: RootViewController {

     var deviceStatusType:Int!
        var valueDic:NSDictionary!
      var deviceType:Int!
    // var view1:UIView!
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
    
    var view2:UIButton!
    var  image4:UIImageView!
    
    var  lable3:UILabel!
    
    var heigh0=96*NOW_SIZE
    
     var lineH=0.6*HEIGHT_SIZE
    
    override func viewWillAppear(_ animated: Bool) {
        
             self.navigationController?.navigationBar.barTintColor=MainColor
        
        if roleString=="3" || roleString=="2" || roleString=="1"{
    
            self.initNet0()
        }else if roleString=="6"{
       
            self.initNet1()
            self.initNet4()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//  [self.navigationController.navigationBar setBarTintColor:MainColor];
        

        self.navigationItem.hidesBackButton=true
        
        self.title="OSS系统"
        
        self.navigationItem.backBarButtonItem?.title="";
        
   self.navigationController?.setNavigationBarHidden(false, animated: false)


        self.initLeftItem()
           roleString=UserDefaults.standard.object(forKey: "roleNum") as! NSString!
        
        serverNumArray=[0,0]
        orderNumArray=[0,0]
        infoString=""
        newInfoType=0
     
        
       self.initUI()
        
   
        if roleString=="3" || roleString=="2" || roleString=="1"{
                self.initUItwo()
        
        }else if roleString=="6"{
              self.initUIThree()
         
            
        }

        
       
    }

    
    func initLeftItem(){
        let item0Name="退出账户"
          let item1Name="工具"
        let item0=DTKDropdownItem.init(title: item0Name, iconName: "Quick", callBack:{ (dropMenuCallBack)->() in
       self.initAlertView()
            
        } )
        let item1=DTKDropdownItem.init(title: item1Name, iconName: "Check", callBack:{ (dropMenuCallBack)->() in
            let vc=ossTool()
            self.navigationController?.pushViewController(vc, animated: true)
            
        } )
        
        let attributes1:NSDictionary = NSDictionary(object:UIFont.systemFont(ofSize: 14*HEIGHT_SIZE),
                                                    forKey: NSFontAttributeName as NSCopying)
        let size1=item0Name.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 30*HEIGHT_SIZE), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes1 as? [String : AnyObject], context: nil)
        
               let H2=self.navigationController?.navigationBar.frame.size.height;
                let bH=16*HEIGHT_SIZE
        
        let menuView=DTKDropdownMenuView.init(type:dropDownTypeLeftItem , frame: CGRect(x: 0*NOW_SIZE, y: (H2!-bH)/2, width: bH, height: bH), dropdownItems: [item0!,item1!], icon:"more2@2x.png")!
        menuView.dropWidth = size1.width+10*NOW_SIZE
        menuView.cellHeight = 30*HEIGHT_SIZE
        menuView.titleFont = UIFont.systemFont(ofSize:14*HEIGHT_SIZE)
        menuView.textColor = COLOR(_R: 102, _G: 102, _B: 102, _A: 1);
        menuView.cellSeparatorColor =  COLOR(_R: 229, _G: 229, _B: 229, _A: 1);
        menuView.textFont = UIFont.systemFont(ofSize:14*HEIGHT_SIZE)
        menuView.animationDuration = 0.2;
   
        let leftItem=UIBarButtonItem.init(customView: menuView)
             self.navigationItem.leftBarButtonItem=leftItem
        self.navigationItem.leftBarButtonItem?.width=bH
   

    }
    
    
    func initAlertView(){
        let alertController = UIAlertController(title: "是否退出账户?", message: nil, preferredStyle:.alert)
        
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
  
           self.resisgerName()
        }
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func initUI(){
    
        imageOne=UIImageView()
        self.imageOne.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: heigh0)
         imageOne.image=UIImage(named: "head_bg_oss_first.png")
        self.view.addSubview(imageOne)
        
    }
    
    
    func initUIThree(){
      
       self.view.backgroundColor=backgroundGrayColor
        
        let lableH=40*HEIGHT_SIZE
        let imageColor1=self.getImageWithColor(color: UIColor.white, size: CGSize(width: SCREEN_Width, height: lableH))
        let imageColor2=self.getImageWithColor(color: COLOR(_R: 222, _G: 222, _B: 222, _A: 1), size: CGSize(width: SCREEN_Width, height: lableH))

      let view1=UIButton()
        view1.frame=CGRect(x: 0*NOW_SIZE, y: heigh0+10*HEIGHT_SIZE, width: SCREEN_Width, height: lableH)
        view1.setBackgroundImage(imageColor1, for: .normal)
        view1.setBackgroundImage(imageColor2, for: .highlighted)
        view1.setBackgroundImage(imageColor2, for: .selected)
        view1.addTarget(self, action:#selector(gotoDevice), for: .touchUpInside)
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
        imageAll.frame=CGRect(x: 2*NOW_SIZE, y:heigh0+55*HEIGHT_SIZE, width: SCREEN_Width-4*NOW_SIZE, height: 170*HEIGHT_SIZE)
        imageAll.image=UIImage(named: "intergrator_device.png")
         self.view.addSubview(imageAll)
        
        for i in 0...1 {
            for K in 0...1 {
                
                let viewW=155*NOW_SIZE
                 let viewH=80*HEIGHT_SIZE
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
                     //    lable1.text=self.integratorValueArray[0] as? String
                        lable1.tag=6000
                         lable2.text="今日发电量(kWh)"
                    }
                    if K==1 {
                        imageP.image=UIImage(named: "inv_iconI.png")
                     //      lable1.text=self.integratorValueArray[2] as? String
                          lable1.tag=6002
                         lable2.text="逆变器总数(台)"
                    }
                }
                if i==1 {
                    if K==0 {
                        imageP.image=UIImage(named: "etotaliconI.png")
                        //  lable1.text=self.integratorValueArray[1] as? String
                          lable1.tag=6001
                          lable2.text="累计发电量(kWh)"
                    }
                    if K==1 {
                        imageP.image=UIImage(named: "power_iconI.png")
                        //   lable1.text=self.integratorValueArray[3] as? String
                          lable1.tag=6003
                        lable2.text="装机功率(W)"
                    }
                }
              
                
                
                
            }
        }
        
        
    }
    
    func initUIThree3(){
        
        for i in 0...3 {
            let L1=self.view.viewWithTag(6000+i) as! UILabel
            L1.text=self.integratorValueArray[i] as? String
        }
   
    
    }
    
    
    
    func initUIFour(){

        let view1 = UIImageView()
        view1.frame=CGRect(x: 2*NOW_SIZE, y:heigh0+55*HEIGHT_SIZE+170*HEIGHT_SIZE, width: SCREEN_Width-4*NOW_SIZE, height: 170*HEIGHT_SIZE)
        view1.isUserInteractionEnabled=true
        view1.image=UIImage(named: "intergrator_device.png")
        self.view.addSubview(view1)
        
        let view1W=SCREEN_Width-4*NOW_SIZE
        
        let view2=UIView()
        view2.frame=CGRect(x:0*NOW_SIZE, y: 10*HEIGHT_SIZE, width:view1W, height: 30*HEIGHT_SIZE)
        view2.backgroundColor=UIColor.clear
        view2.isUserInteractionEnabled=true
        view2.tag=2600
        let tap=UITapGestureRecognizer(target: self, action: #selector(goDetailDevice(tap:)))
        view2.addGestureRecognizer(tap)
        view1.addSubview(view2)
        
        let Lable3=UILabel()
        Lable3.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: view1W, height: 30*HEIGHT_SIZE)
        let lable3String="已接入逆变器总数:"
        let lable3AllString=NSString(format: "%@%d", lable3String,valueDic.object(forKey: "totalNum") as! Int)
        Lable3.text=lable3AllString as String
        Lable3.textColor=MainColor
        Lable3.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        Lable3.adjustsFontSizeToFitWidth=true
           Lable3.textAlignment=NSTextAlignment.center
        view2.addSubview(Lable3)
        
        let size1=self.getStringSize(Float(16*HEIGHT_SIZE), wsize: MAXFLOAT, hsize: Float(30*HEIGHT_SIZE), stringName: lable3AllString as String!)
        
        let image1=UIImageView()
        image1.frame=CGRect(x:(view1W+size1.width)/2+15*NOW_SIZE, y: 11.5*HEIGHT_SIZE, width: 5*HEIGHT_SIZE, height: 8*HEIGHT_SIZE)
        image1.image=UIImage.init(named:"moreOSS.png")
        view2.addSubview(image1)
        
        var nameArray:NSArray=[]
        var colorArray:NSArray=[]
        var valueArray:NSArray=[]
        if self.deviceType==0{
            nameArray=["在线:","等待:","故障:","离线:"]
            colorArray=[COLOR(_R: 2, _G: 232, _B:2, _A: 1),COLOR(_R: 233, _G: 223, _B:74, _A: 1),COLOR(_R: 238, _G: 73, _B:51, _A: 1),COLOR(_R: 181, _G: 186, _B:189, _A: 1)]
            valueArray=[valueDic.object(forKey: "onlineNum") as! Int,valueDic.object(forKey: "waitNum") as! Int,valueDic.object(forKey: "faultNum") as! Int,valueDic.object(forKey: "offlineNum") as! Int]
        }
        
        if self.deviceType==1{
            colorArray=[COLOR(_R: 2, _G: 232, _B:2, _A: 1),COLOR(_R: 181, _G: 186, _B:189, _A: 1),COLOR(_R: 154, _G: 229, _B:128, _A: 1),COLOR(_R: 222, _G: 211, _B:91, _A: 1),COLOR(_R: 238, _G: 73, _B:51, _A: 1)]
            nameArray=["在线:","离线:","充电:","放电:","故障:"]
            valueArray=[valueDic.object(forKey: "onlineNum") as! Int,valueDic.object(forKey: "offlineNum") as! Int,valueDic.object(forKey: "chargeNum") as! Int,valueDic.object(forKey: "dischargeNum") as! Int,valueDic.object(forKey: "faultNum") as! Int]
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
                let lable3String=String(format: "%@%d", nameArray[i+2*K] as! NSString,valueArray[i+2*K] as! Int)
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

        
        let vc=intergratorDeviceList()
        vc.deviceStatusType=self.deviceStatusType
  
        vc.netDic=["deviceType":deviceType,"accessStatus":1,"agentCode":0,"plantName":"","userName":"","datalogSn":"","deviceSn":""]
        vc.deviceType=self.deviceType
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func initNet4(){
        
    self.deviceType=0
     let   netDic1=["deviceType":deviceType,"accessStatus":1,"agentCode":0,"plantName":"","userName":"","datalogSn":"","deviceSn":""] as [String : Any]
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:netDic1 as [AnyHashable : Any]!, paramarsSite: "/api/v1/customer/device_num", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/customer/device_num=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objDic=jsonDate["obj"] as! Dictionary<String, Any>
                    if self.deviceType==0{
                        self.valueDic=["faultNum":objDic["faultNum"] as! Int,"nullNum":objDic["nullNum"] as! Int,"offlineNum":objDic["offlineNum"] as! Int,"onlineNum":objDic["onlineNum"] as! Int,"totalNum":objDic["totalNum"] as! Int,"waitNum":objDic["waitNum"] as! Int]
                    }
                    if self.deviceType==1{
                        self.valueDic=["chargeNum":objDic["chargeNum"]as! Int,"dischargeNum":objDic["dischargeNum"]as! Int,"faultNum":objDic["faultNum"]as! Int,"nullNum":objDic["nullNum"]as! Int,"offlineNum":objDic["offlineNum"]as! Int,"onlineNum":objDic["onlineNum"]as! Int,"totalNum":objDic["totalNum"]as! Int]
                    }
                    
                    
                    self.initUIFour()
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    

    
    
     func getImageWithColor(color: UIColor, size: CGSize) -> UIImage
    {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func initUItwo(){
     

             let lableH=40*HEIGHT_SIZE
   
        let imageColor1=self.getImageWithColor(color: UIColor.clear, size: CGSize(width: SCREEN_Width, height: lableH))
        let imageColor2=self.getImageWithColor(color: COLOR(_R: 222, _G: 222, _B: 222, _A: 1), size: CGSize(width: SCREEN_Width, height: lableH))
        

        
        let view2H=50*HEIGHT_SIZE
       view2=UIButton()
        view2.frame=CGRect(x: 0*NOW_SIZE, y: heigh0, width: SCREEN_Width, height: view2H)
        view2.setBackgroundImage(imageColor1, for: .normal)
        view2.setBackgroundImage(imageColor2, for: .highlighted)
        view2.setBackgroundImage(imageColor2, for: .selected)
        view2.addTarget(self, action:#selector(goToNew), for: .touchUpInside)
        self.view.addSubview(view2)
        
        
            let gifWebH2=20*HEIGHT_SIZE
            
            let time: TimeInterval = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                
                let bundleDBPath:String? = Bundle.main.path(forResource: "message_icon2", ofType: "gif")
                let data1=NSData.init(contentsOfFile:bundleDBPath!)
                
                let gifWeb=UIWebView()
                gifWeb.frame=CGRect(x: 10*NOW_SIZE, y: 4*HEIGHT_SIZE, width: gifWebH2, height: gifWebH2*1.2)
                gifWeb.load(data1! as Data, mimeType:"image/gif", textEncodingName: String(), baseURL:NSURLComponents().url!)
                gifWeb.isUserInteractionEnabled=false
                gifWeb.scalesPageToFit=true
                gifWeb.isOpaque=false
                gifWeb.backgroundColor=UIColor.clear
                self.view2.addSubview(gifWeb)
                
            }
            
        
        let lable2H=25*HEIGHT_SIZE
            let  lable2=UILabel()
            lable2.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 250*NOW_SIZE, height: lable2H)
            lable2.text="最新接收消息"
            lable2.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            lable2.textAlignment=NSTextAlignment.left
            lable2.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
            view2.addSubview(lable2)
            
            let image4H=5*HEIGHT_SIZE
            image4=UIImageView()
            image4.layer.masksToBounds=true
            image4.layer.cornerRadius=image4H/2
            image4.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE, y: lable2H-2*HEIGHT_SIZE+(lable2H-image4H)/2, width: image4H, height: image4H)
            
            view2.addSubview(image4)
            
            lable3=UILabel()
            lable3.frame=CGRect(x: 10*NOW_SIZE+gifWebH2+10*NOW_SIZE+image4H+5*NOW_SIZE, y: lable2H-2*HEIGHT_SIZE, width: 150*NOW_SIZE, height: lable2H)
            lable3.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
            lable3.textAlignment=NSTextAlignment.left
            lable3.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            view2.addSubview(lable3)
            
        let viewLine1=UIView()
        viewLine1.frame=CGRect(x: 0*NOW_SIZE, y: heigh0+view2H, width: SCREEN_Width, height: lineH)
        viewLine1.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
        self.view.addSubview(viewLine1)
        
        
        let AllH=160*HEIGHT_SIZE-45*HEIGHT_SIZE;
        for i in 0...1 {
            let viewAll=UIView()
            viewAll.frame=CGRect(x: 0*NOW_SIZE, y: viewLine1.frame.origin.y+(AllH+5*HEIGHT_SIZE)*CGFloat(i), width: SCREEN_Width, height: AllH)
            viewAll.backgroundColor=UIColor.clear
            self.view.addSubview(viewAll)
            
            
            let view1=UIButton()
            view1.frame=CGRect(x: 0*NOW_SIZE, y: 0, width: SCREEN_Width, height: lableH)
            view1.setBackgroundImage(imageColor1, for: .normal)
            view1.setBackgroundImage(imageColor2, for: .highlighted)
            view1.setBackgroundImage(imageColor2, for: .selected)
             view1.tag=2000+i
            view1.addTarget(self, action:#selector(gotoServer), for: .touchUpInside)
            viewAll.addSubview(view1)
            
            
//            let view1=UIView()
//            view1.frame=CGRect(x: 0*NOW_SIZE, y: 0, width: SCREEN_Width, height: lableH)
//            view1.backgroundColor=UIColor.clear
//            view1.isUserInteractionEnabled=true
//            view1.tag=2000+i
//            let tap0=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
//                view1.addGestureRecognizer(tap0)
//            viewAll.addSubview(view1)
            
            
            let imageH=20*HEIGHT_SIZE
            let imageV = UIImageView()
            imageV.frame=CGRect(x: 10*NOW_SIZE, y: (lableH-imageH)/2, width: imageH, height: imageH)
            imageV.image=UIImage(named: "work_order_icon.png")
            if i==0 {
                 imageV.image=UIImage(named: "online_server_icon.png")
            }
         
            view1.addSubview(imageV)
            
            let  lable1=UILabel()
            lable1.frame=CGRect(x: 10*NOW_SIZE+imageH+10*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 150*NOW_SIZE, height: lableH)
            lable1.text="在线客服"
            if i==1 {
             lable1.text="工单系统"
            }
            lable1.textColor=UIColor.black
            lable1.textAlignment=NSTextAlignment.left
            lable1.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
            view1.addSubview(lable1)
            
            let imageH2=20*HEIGHT_SIZE
            let imageV2 = UIImageView()
            imageV2.frame=CGRect(x: (SCREEN_Width-20*NOW_SIZE)-imageH2, y: (lableH-imageH2)/2, width: imageH2, height: imageH2)
            imageV2.image=UIImage(named: "firstGo.png")
            view1.addSubview(imageV2)

            
            let viewLine=UIView()
            if i==0 {
                 viewLine.frame=CGRect(x: 0*NOW_SIZE, y:lableH, width: SCREEN_Width, height: lineH)
            }else{
               viewLine.frame=CGRect(x: 0*NOW_SIZE, y: lableH, width: SCREEN_Width, height: lineH)
            }
            viewLine.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLine)
            
            let viewButtonH=80*HEIGHT_SIZE
            
            let viewLineCenter=UIView()
            viewLineCenter.frame=CGRect(x: SCREEN_Width/2, y: viewLine.frame.origin.y, width: 1*NOW_SIZE, height: viewButtonH)
            viewLineCenter.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLineCenter)
            
            
            let imageColor3=self.getImageWithColor(color: UIColor.clear, size: CGSize(width:  SCREEN_Width/2, height: viewButtonH))
            let imageColor4=self.getImageWithColor(color: COLOR(_R: 222, _G: 222, _B: 222, _A: 1), size: CGSize(width:  SCREEN_Width/2, height: viewButtonH))
            
            let viewButton=UIButton()
            viewButton.frame=CGRect(x: 0*NOW_SIZE, y: viewLine.frame.origin.y+lineH, width: SCREEN_Width/2, height: viewButtonH)
            viewButton.setBackgroundImage(imageColor3, for: .normal)
            viewButton.setBackgroundImage(imageColor4, for: .highlighted)
            viewButton.setBackgroundImage(imageColor4, for: .selected)
            viewButton.tag=3000+i
            viewButton.addTarget(self, action:#selector(gotoServer), for: .touchUpInside)
            viewAll.addSubview(viewButton)
            
            
//            let viewButton=UIView()
//            viewButton.frame=CGRect(x: 0*NOW_SIZE, y: viewLine.frame.origin.y+lineH, width: SCREEN_Width/2, height: viewButtonH)
//            viewButton.backgroundColor=UIColor.clear
//            viewButton.isUserInteractionEnabled=true
//            viewButton.tag=3000+i
//            let tap2=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
//            viewButton.addGestureRecognizer(tap2)
      //      viewAll.addSubview(viewButton)
            
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
            ButtonLable2.tag=3100+i
       
            ButtonLable2.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            ButtonLable2.textAlignment=NSTextAlignment.center
            ButtonLable2.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            viewButton.addSubview(ButtonLable2)
            
            
            let viewButton1=UIButton()
            viewButton1.frame=CGRect(x: SCREEN_Width/2, y: viewLine.frame.origin.y+lineH, width: SCREEN_Width/2, height: viewButtonH)
            viewButton1.setBackgroundImage(imageColor3, for: .normal)
            viewButton1.setBackgroundImage(imageColor4, for: .highlighted)
            viewButton1.setBackgroundImage(imageColor4, for: .selected)
            viewButton1.tag=4000+i
            viewButton1.addTarget(self, action:#selector(gotoServer), for: .touchUpInside)
            viewAll.addSubview(viewButton1)
            
//            let viewButton1=UIView()
//            viewButton1.frame=CGRect(x: SCREEN_Width/2, y: viewLine.frame.origin.y+lineH, width: SCREEN_Width/2, height: viewButtonH)
//            viewButton1.backgroundColor=UIColor.clear
//            viewButton1.isUserInteractionEnabled=true
//            viewButton1.tag=4000+i
//            let tap3=UITapGestureRecognizer(target: self, action: #selector(gotoServer))
//            viewButton1.addGestureRecognizer(tap3)
//            viewAll.addSubview(viewButton1)
            
            
            let ButtonImag1 = UIImageView()
            ButtonImag1.frame=CGRect(x: (SCREEN_Width/4-ButtonImageH/2), y: 10*HEIGHT_SIZE, width: ButtonImageH, height: ButtonImageH)
           
            if i==1 {
                ButtonImag1.image=UIImage(named: "Untreated1111.png")
            }
            if i==0{
             ButtonImag1.image=UIImage(named: "processingOss.png")
            }
            viewButton1.addSubview(ButtonImag1)
            
            let  ButtonLable21=UILabel()
            ButtonLable21.frame=CGRect(x:0, y: 15*HEIGHT_SIZE+ButtonImageH, width: SCREEN_Width/2, height: 20*HEIGHT_SIZE)
         
            ButtonLable21.tag=4100+i
       
            ButtonLable21.textColor=COLOR(_R: 51, _G: 51, _B: 51, _A: 1)
            ButtonLable21.textAlignment=NSTextAlignment.center
            ButtonLable21.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
            viewButton1.addSubview(ButtonLable21)
            
            let viewLine1=UIView()
            viewLine1.frame=CGRect(x: 0*NOW_SIZE, y: viewLine.frame.origin.y+lineH+viewButtonH, width: SCREEN_Width, height: lineH)
            viewLine1.backgroundColor=COLOR(_R: 222, _G: 222, _B: 222, _A: 1)
            viewAll.addSubview(viewLine1)

        }
        
        
        let deviceViewY=viewLine1.frame.origin.y+115*HEIGHT_SIZE+115*HEIGHT_SIZE+15*HEIGHT_SIZE
         let deviceViewH=70*HEIGHT_SIZE
               let deviceView=UIButton()
                deviceView.frame=CGRect(x: (SCREEN_Width-deviceViewH)/2, y: deviceViewY+15*HEIGHT_SIZE, width: deviceViewH, height: deviceViewH)
                deviceView.setBackgroundImage(UIImage(named: "search_icon_nor.png"), for: .normal)
                deviceView.setBackgroundImage(UIImage(named: "search_icon_click.png"), for: .highlighted)
                 deviceView.setBackgroundImage(UIImage(named: "search_icon_click.png"), for: .selected)
                deviceView.addTarget(self, action:#selector(gotoDevice), for: .touchUpInside)
                self.view.addSubview(deviceView)
        
        
        
    }
    

    
    
    func initUItwo2(){
        
           view2.isUserInteractionEnabled=true
        if infoString=="" {
            lable3.text="暂无消息"
        }else{
             lable3.text=infoString! as String
        }
      
        
        let L1=self.view.viewWithTag(3100) as! UILabel
        L1.text=String(format: "%@:%d", "待跟进",(serverNumArray[0] as? Int)!)
        
        let L2=self.view.viewWithTag(3101) as! UILabel
        L2.text=String(format: "%@:%d", "待接收",(orderNumArray[0] as? Int)!)
        
        let L3=self.view.viewWithTag(4100) as! UILabel
        L3.text=String(format: "%@:%d", "处理中",serverNumArray[1] as! Int)
        
        let L4=self.view.viewWithTag(4101) as! UILabel
        L4.text=String(format: "%@:%d", "服务中",orderNumArray[1] as! Int)
        

        
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
        
        
    }
    
    
    
    
    func goToNew(){
    UserDefaults.standard.set(false, forKey: "newInfoEnble")
        
        if  newInfoType==1 {
            let vc=ossQuetionDetail()
            let id=NSString(format: "%d", infoID)
            vc.qusetionId=id as String!
         //   vc.serverUrl=infoAddress! as String
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
                    
                    self.initUItwo2()
                    
                    
                }else{
                       self.initUItwo2()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
              self.initUItwo2()
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
                    
                                 self.initUIThree3()
                    }
                    
       
                    
                }else{
                      self.initUIThree3()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.initUIThree3()
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
        
             UserDefaults.standard.set("N", forKey: "firstGoToOss")
        
        
      
        
        let vc=loginViewController()
        vc.oldName=oldName as! String!
            vc.oldPassword=oldPassword as! String!
        self.navigationController?.pushViewController(vc, animated: true)
        

        
        
    }
    
    
    func gotoServer(Tap:UIButton ) {
        
        
        
        let vc=ossServerFirst()
        if Tap.tag==2000 {
               vc.questionOrOrder=1
              vc.statusInt=10
               vc.firstNum=0
            vc.secondNum=0
        }
        if Tap.tag==2001 {
            vc.questionOrOrder=2
            vc.statusInt=10
            vc.firstNum=1
            vc.secondNum=0
        }
        
        if Tap.tag==3000 {
            vc.questionOrOrder=1
            vc.statusInt=3
            vc.secondNum=2
            vc.firstNum=0
        }
        
        if Tap.tag==4000 {
            vc.questionOrOrder=1
            vc.statusInt=1
            vc.secondNum=3
            vc.firstNum=0
        }
        
        if Tap.tag==3001 {
            vc.questionOrOrder=2
            vc.statusInt=2
            vc.secondNum=1
            vc.firstNum=1
        }
        
        if Tap.tag==4001{
            vc.questionOrOrder=2
            vc.statusInt=3
            vc.secondNum=2
            vc.firstNum=1
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoDevice()  {
        
        if roleString=="3" || roleString=="2" || roleString=="1"{
              UserDefaults.standard.set("", forKey: "searchDeviceAddress")
            
            let vc=ossDeviceFirst()
            vc.serverListArray=self.serverListArray
            self.navigationController?.pushViewController(vc, animated: true)
        }else if roleString=="6"{
            UserDefaults.standard.set("", forKey: "searchDeviceAddress")
            
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
