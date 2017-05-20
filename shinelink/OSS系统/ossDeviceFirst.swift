//
//  ossDeviceFirst.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossDeviceFirst: RootViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate{

    var searchBar:UISearchBar!
      var view1:UIView!
      var button1:UIButton!
     var view2:UIView!
    
    var view3:UIView!
     var view4:UIView!
    var goNetString:NSString!
    var tableView:UITableView!
   
 
    var cellNameArray:NSArray!
    var cellValue1Array:NSArray!
     var cellValue2Array:NSArray!
     var cellValue3Array:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.title="设备搜索"
        
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
        
       let RfSnLable=UILabel()
         RfSnLable.frame=CGRect(x: 0*NOW_SIZE, y: 35*HEIGHT_SIZE, width: SCREEN_Width, height: 40*HEIGHT_SIZE)
        RfSnLable.text="选择搜索类型"
        RfSnLable.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
        RfSnLable.textAlignment=NSTextAlignment.center
        RfSnLable.font=UIFont.systemFont(ofSize: 15*HEIGHT_SIZE)
        view3.addSubview(RfSnLable)
        
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
             button2.titleLabel?.font=UIFont.systemFont(ofSize: 13*HEIGHT_SIZE)
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
               button2.titleLabel?.font=UIFont.systemFont(ofSize: 13*HEIGHT_SIZE)
             button2.titleLabel?.adjustsFontSizeToFitWidth=true
            button2.layer.borderColor=MainColor.cgColor;
            button2.isSelected=false
            button2.backgroundColor=UIColor.clear
            button2.addTarget(self, action:#selector(butttonChange(uibutton:)), for: .touchUpInside)
            view3.addSubview(button2)
            
        }
        
    }
    
    func initTableView(){
      
       
        
      
        
        cellNameArray=["电站名称:","所属用户名:"];
        cellValue1Array=["my station","my station","my station","my station","my station"];
          cellValue2Array=["yangwen","yangwen","yangwen","yangwen","yangwen"];
        
       tableView=UITableView()
        let H1=35*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
           tableView.separatorStyle = UITableViewCellSeparatorStyle.none
         tableView.register(deviceFirstCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellValue1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 46*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
      //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceFirstCell
        let lable1=NSString(format: "%@%@", cellNameArray[0]as!NSString,cellValue1Array[indexPath.row]as!NSString)
         let lable2=NSString(format: "%@%@", cellNameArray[1]as!NSString,cellValue2Array[indexPath.row]as!NSString)
        cell.TitleLabel1.text=lable1 as String
         cell.TitleLabel2.text=lable2 as String

        return cell
        
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goView=deviceListViewController()
        self.navigationController?.pushViewController(goView, animated: true)
        
    }
    
    
    
    func butttonChange(uibutton: UIButton)  {
        
         self.changeStateT(Tag: uibutton.tag)
        
 
        if uibutton.isSelected {
            uibutton.backgroundColor=UIColor.white
            uibutton.setTitleColor(MainColor, for: .normal)
             uibutton.isSelected=false
            self.title="设备搜索"
            if (view4 != nil){
                view4.removeFromSuperview()
                view4=nil
            }
            
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
            let titleName1=uibutton.titleLabel?.text
            let titleName2="当前设备类型:"
            let titleName=NSString(format: "%@%@", titleName2,titleName1!)
            self.title=titleName as String
            
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
            button2.tag=2007
            button2.layer.borderWidth=0.8*HEIGHT_SIZE;
            button2.layer.cornerRadius=10*HEIGHT_SIZE;
         button2.titleLabel?.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
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
        button4.tag=2008
        button4.layer.borderWidth=0.8*HEIGHT_SIZE;
        button4.layer.cornerRadius=10*HEIGHT_SIZE;
         button4.titleLabel?.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
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
  
        if A==7 {
            self.changeState(Tag: 8)
        }else if A==8 {
            self.changeState(Tag: 7)
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
    
       var choiceBool=false
        
        for i in 0...6{
            let A=2000+i
            let B1 = view3.viewWithTag(A) as! UIButton
            if B1.isSelected {
                goNetString=String(format: "%d", A) as NSString!
                if A==2004||A==2005||A==2006{
                     let C1 = view4.viewWithTag(2007) as! UIButton
                     let C2 = view4.viewWithTag(2008) as! UIButton
                    if C1.isSelected==false&&C2.isSelected==false {
                         self.showToastView(withTitle: "请选择序列号或别名")
                        return
                    }
                }
                choiceBool=true
            }
        }
    
        if choiceBool==false {
               self.showToastView(withTitle: "请选择搜索类型")
            return
        }
    
        if (view3 != nil){
            view3.removeFromSuperview()
            view3=nil
        }
        
        self.initTableView()
        
        
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if (tableView != nil){
            tableView.removeFromSuperview()
            tableView=nil
            self.title="设备搜索"
            self.initUiTwo()
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
