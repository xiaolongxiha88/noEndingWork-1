//
//  ossDeviceFirst.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossDeviceFirst: RootViewController,UISearchBarDelegate{

    var searchBar:UISearchBar!
      var view1:UIView!
      var button1:UIButton!
     var view2:UIView!
    
    var view3:UIView!
     var view4:UIView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.initUI()
        self.initUiTwo()
    }

    
    func initUI(){
    
      
        view1=UIView()
         self.view1.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        view1.backgroundColor=MainColor
        self.view.addSubview(view1)
        
        
        searchBar=UISearchBar();
            self.searchBar.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width-40*NOW_SIZE, height: 30*HEIGHT_SIZE)
         self.searchBar.delegate = self
        self.searchBar.placeholder = "输入搜索内容"
        for subview in searchBar.subviews {
            if subview .isKind(of: NSClassFromString("UIView")!) {
                subview.backgroundColor=UIColor.clear
                subview.subviews[0].removeFromSuperview()
            }
        }
        searchBar.barTintColor=UIColor.clear
        searchBar.backgroundColor=UIColor.clear
         //searchBar.showsCancelButton = true
         view1.addSubview(searchBar)
    
        view2=UIView()
        self.view2.frame=CGRect(x: 280*NOW_SIZE, y: 0*HEIGHT_SIZE, width: 40*NOW_SIZE, height:30*HEIGHT_SIZE)
        view2.backgroundColor=MainColor
        view2.isUserInteractionEnabled=true
        let tap=UITapGestureRecognizer(target: self, action: #selector(ossDeviceFirst.searchDevice))
        view2.addGestureRecognizer(tap)
        self.view.addSubview(view2)
        
        button1=UIButton()
        button1.frame=CGRect(x: 5*NOW_SIZE, y: 4*HEIGHT_SIZE, width: 22*HEIGHT_SIZE, height:20*HEIGHT_SIZE)
        button1.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        button1.addTarget(self, action:#selector(searchDevice), for: .touchUpInside)
        view2.addSubview(button1)
        
        
        
    }
    
    
    
    func initUiTwo(){
        
        view3=UIView()
        view3.frame=CGRect(x: 0*NOW_SIZE, y: 40*HEIGHT_SIZE, width: SCREEN_Width, height: 500*HEIGHT_SIZE)
        view3.backgroundColor=UIColor.clear
        self.view.addSubview(view3)
        
        let buttonNameArray1=["用户名","电站名","手机号","邮箱"]
         let buttonNameArray2=["采集器","逆变器","储能机"]
        
        for i in 0...3{
            let button2=UIButton()
           
            button2.frame=CGRect(x: 16*NOW_SIZE+76*NOW_SIZE*CGFloat(i), y: 90*HEIGHT_SIZE, width: 60*NOW_SIZE, height:25*HEIGHT_SIZE)
            // button2.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
            button2.setTitle(buttonNameArray1[i], for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(UIColor.white, for: .highlighted)
            button2.tag=i+2000
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=12*HEIGHT_SIZE;
             button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
            view3.addSubview(button2)
        
        }
  
        for i in 0...2{
            let button2=UIButton()
            button2.frame=CGRect(x: 35*NOW_SIZE+95*NOW_SIZE*CGFloat(i), y: 150*HEIGHT_SIZE, width: 60*NOW_SIZE, height:25*HEIGHT_SIZE)
            // button2.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
            button2.setTitle(buttonNameArray2[i], for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(UIColor.white, for: .highlighted)
            button2.tag=i+2004
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=12*HEIGHT_SIZE;
             button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
            view3.addSubview(button2)
            
        }
        
    }
    
    
    func butttonChange(uibutton: UIButton)  {
        
         self.changeStateT(Tag: uibutton.tag)
        
 
        if uibutton.isSelected {
            uibutton.backgroundColor=UIColor.white
            uibutton.setTitleColor(MainColor, for: .normal)
             uibutton.isSelected=false
        }else{
        uibutton.backgroundColor=MainColor
        uibutton.setTitleColor(UIColor.white, for: .normal)
            uibutton.isSelected=true
            if uibutton.tag==2004||uibutton.tag==2005||uibutton.tag==2006{
                getSmallButton(Tag: uibutton.tag)
            }
            if uibutton.tag==2000||uibutton.tag==2001||uibutton.tag==2002||uibutton.tag==2003{
                if (view4 != nil){
                    view4.removeFromSuperview()
                    view4=nil
                }
            }
        }
        
    }
    
    
    func butttonChange2(uibutton: UIButton)  {
        
        self.changeStateT(Tag: uibutton.tag)
        
        
        if uibutton.isSelected {
            uibutton.backgroundColor=UIColor.white
            uibutton.setTitleColor(MainColor, for: .normal)
            uibutton.isSelected=false
        }else{
            uibutton.backgroundColor=MainColor
            uibutton.setTitleColor(UIColor.white, for: .normal)
            uibutton.isSelected=true

        }
        
    }
    
    func getSmallButton(Tag:Int)  {
        if (view4 != nil){
            view4.removeFromSuperview()
            view4=nil
        }
       
        
        view4=UIView()
        view4.frame=CGRect(x:0*NOW_SIZE, y: 220*HEIGHT_SIZE, width: SCREEN_Width, height:20*HEIGHT_SIZE)
        view4.backgroundColor=UIColor.clear
        self.view.addSubview(view4)
        
           let i=Tag-2004
        
            let button2=UIButton()
            button2.frame=CGRect(x: 5*NOW_SIZE+95*NOW_SIZE*CGFloat(i), y: 0*HEIGHT_SIZE, width: 50*NOW_SIZE, height:20*HEIGHT_SIZE)
            button2.setTitle("序列号", for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(UIColor.white, for: .highlighted)
            button2.tag=2008
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=10*HEIGHT_SIZE;
            button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange2(uibutton:)), for: .touchUpInside)
            view4.addSubview(button2)
        
        let button4=UIButton()
        button4.frame=CGRect(x: 75*NOW_SIZE+95*NOW_SIZE*CGFloat(i), y: 0*HEIGHT_SIZE, width: 50*NOW_SIZE, height:20*HEIGHT_SIZE)
        button4.setTitle("别名", for: .normal)
        button4.setTitleColor(MainColor, for: .normal)
        button4.setTitleColor(UIColor.white, for: .highlighted)
        button4.tag=2009
        button4.layer.borderWidth=0.8*HEIGHT_SIZE;
        button4.layer.cornerRadius=10*HEIGHT_SIZE;
        button4.titleLabel?.adjustsFontSizeToFitWidth=true
        button4.layer.borderColor=MainColor.cgColor;
        button4.isSelected=false
        button4.backgroundColor=UIColor.clear
        button4.addTarget(self, action:#selector(butttonChange2(uibutton:)), for: .touchUpInside)
        view4.addSubview(button4)
       
    
    }
    
    
    func changeStateT(Tag:Int)  {
        let A=Tag-2000
        if A<=6 {
            for i in 0...6{
                if i==A {
                    
                }else{
                    self.changeState(Tag: i)
                }
            }
        }
  
        if A==8 {
            self.changeState(Tag: 9)
        }else if A==9 {
            self.changeState(Tag: 8)
        }
        
    }
    
    func changeState( Tag:Int)  {
        
        let A=2000+Tag
     
        if A<=2006 {
             let B1 = view3.viewWithTag(A) as! UIButton
            B1.isSelected=false
            B1.backgroundColor=UIColor.white
            B1.setTitleColor(MainColor, for: .normal)
        }else{
            let B1 = view4.viewWithTag(A) as! UIButton
            B1.isSelected=false
            B1.backgroundColor=UIColor.white
            B1.setTitleColor(MainColor, for: .normal)
        }
       

   
    }
    
    
    func searchDevice(){
    
    
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
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
