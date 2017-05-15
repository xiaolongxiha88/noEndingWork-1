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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//  [self.navigationController.navigationBar setBarTintColor:MainColor];
        self.navigationController?.navigationBar.barTintColor=MainColor
        self.navigationItem.hidesBackButton=true
        
        self.title="OSS系统"
        
        self.navigationItem.backBarButtonItem?.title="";
        
       self.initUI()
    }

    
    func initUI(){
    
        let heigh0=96*NOW_SIZE
        
        imageOne=UIImageView()
        self.imageOne.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: heigh0)
         imageOne.image=UIImage(named: "title_bg.png")
        self.view.addSubview(imageOne)
    
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
        
    }
    
    
    func gotoServer()  {
        
        let vc=ossServerFirst()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoDevice()  {
        
        let vc=ossDeviceFirst()
        self.navigationController?.pushViewController(vc, animated: true)
        
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
