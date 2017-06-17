//
//  ossServerFirst.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossServerFirst: RootViewController,UISearchBarDelegate {

    var searchBar:UISearchBar!
    var view1:UIView!
    var button1:UIButton!
    var view2:UIView!
    var lable1:UILabel!
    var lable2:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap=UITapGestureRecognizer(target: self, action: #selector(keyboardHide(tap:)))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        
       self.initUI()
    }
    
    func keyboardHide(tap:UITapGestureRecognizer){
        self.searchBar.resignFirstResponder()
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
        
       
        let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 30*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=2
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=["全部","处理中","待跟进","未处理","已处理"]
        buttonView.initUI()
        self.view .addSubview(buttonView)
        
        lable1=UILabel()
        lable1.frame=CGRect(x: 10*NOW_SIZE, y: 60*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
        lable1.text="全部工单"
        lable1.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        lable1.textAlignment=NSTextAlignment.left
        lable1.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        self.view.addSubview(lable1)
        
        lable2=UILabel()
        lable2.frame=CGRect(x: 160*NOW_SIZE, y: 60*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
        lable2.text="数量:111"
        lable2.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        lable2.textAlignment=NSTextAlignment.right
        lable2.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        self.view.addSubview(lable2)
        
     let view0=UIView()
        view0.frame=CGRect(x: 10*NOW_SIZE, y: 80*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 2*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        
        self.view.addSubview(view0)
        
    }
    
    func searchDevice(){
    
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
