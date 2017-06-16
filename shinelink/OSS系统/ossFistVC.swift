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

        
        
           roleString=UserDefaults.standard.object(forKey: "roleNum") as! NSString!
        
       self.initUI()
        
         self.initUItwo()
      

        
       
    }

    
    func initUI(){
    
      
        
        imageOne=UIImageView()
        self.imageOne.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: heigh0)
         imageOne.image=UIImage(named: "title_bg.png")
        self.view.addSubview(imageOne)
    
        
        
    }
    
    
    func initUItwo(){
     
        buttonOne=UIButton()
        buttonOne.frame=CGRect(x: 10*NOW_SIZE, y: heigh0+10*HEIGHT_SIZE, width: 300*NOW_SIZE, height:heigh0)
        buttonOne.setBackgroundImage(UIImage(named: "gongdan_bg.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        buttonOne.addTarget(self, action:#selector(gotoServer), for: .touchUpInside)
        self.view.addSubview(buttonOne)
        
        buttonTwo=UIButton()
        buttonTwo.frame=CGRect(x: 10*NOW_SIZE, y: (heigh0+10*HEIGHT_SIZE)*2, width: 300*NOW_SIZE, height:heigh0)
        buttonTwo.setBackgroundImage(UIImage(named: "device_bg.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        buttonTwo.addTarget(self, action:#selector(gotoDevice), for: .touchUpInside)
        self.view.addSubview(buttonTwo)
        
        buttonThree=UIButton()
        buttonThree.frame=CGRect(x: 60*NOW_SIZE, y: (heigh0+10*HEIGHT_SIZE)*2+heigh0+160*HEIGHT_SIZE, width: 200*NOW_SIZE, height:30*HEIGHT_SIZE)
        buttonThree.backgroundColor=COLOR(_R: 242, _G: 242, _B: 242, _A: 1)
        buttonThree.setTitle("退出", for: .normal)
        buttonThree.layer.borderWidth=0.8*HEIGHT_SIZE;
        buttonThree.layer.cornerRadius=16*HEIGHT_SIZE;
        buttonThree.titleLabel?.adjustsFontSizeToFitWidth=true
        buttonThree.layer.borderColor=COLOR(_R: 242, _G: 242, _B: 242, _A: 1).cgColor;
         buttonThree.titleLabel?.font=UIFont.systemFont(ofSize: 16*HEIGHT_SIZE)
        buttonThree.setTitleColor(COLOR(_R: 102, _G: 102, _B: 102, _A: 1), for: .normal)
        buttonThree.setTitleColor(COLOR(_R: 238, _G: 73, _B: 51, _A: 1), for: .highlighted)
        buttonThree.addTarget(self, action:#selector(resisgerName), for: .touchUpInside)
        self.view.addSubview(buttonThree)
        
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
    
    
    func gotoServer()  {
        
//        let vc=ossServerFirst()
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc=ossServerFirst()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoDevice()  {
        
        if roleString=="2" || roleString=="0"{
            let vc=ossDeviceFirst()
            vc.serverListArray=self.serverListArray
            self.navigationController?.pushViewController(vc, animated: true)
        }else if roleString=="5" || roleString=="6"{
            let vc=IntegratorFirst()
            self.navigationController?.pushViewController(vc, animated: true)
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
