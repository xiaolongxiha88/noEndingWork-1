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
      var button2:UIButton!
     var button3:UIButton!
     var button4:UIButton!
     var button5:UIButton!
     var button6:UIButton!
     var button7:UIButton!
    
    var button11:UIButton!
      var button12:UIButton!
    var button21:UIButton!
      var button22:UIButton!
     var button31:UIButton!
     var button32:UIButton!
    
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
        
    
        for i in 0...3{
            let button2=UIButton()
           
            button2.frame=CGRect(x: 16*NOW_SIZE+76*NOW_SIZE*CGFloat(i), y: 30*HEIGHT_SIZE, width: 60*NOW_SIZE, height:25*HEIGHT_SIZE)
            // button2.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
            button2.setTitle("电站名", for: .normal)
            button2.setTitleColor(MainColor, for: .normal)
            button2.setTitleColor(UIColor.white, for: .highlighted)
            button2.tag=i+2000
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=12*HEIGHT_SIZE;
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
            view3.addSubview(button2)
        
        }
  
        
    }
    
    
    func butttonChange(uibutton: UIButton)  {
        if uibutton.isSelected {
            uibutton.backgroundColor=UIColor.white
            uibutton.setTitleColor(MainColor, for: .normal)
             button2.isSelected=false
        }else{
        uibutton.backgroundColor=MainColor
        uibutton.setTitleColor(UIColor.white, for: .normal)
            button2.isSelected=true
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
