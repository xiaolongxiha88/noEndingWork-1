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
    var button22:UIButton!
    
    var addressLable:UILabel!
    var view3:UIView!
     var view4:UIView!
    var goNetString:NSString!
    var tableView:UITableView!
    var addressString:NSString!
     var getAddress:NSString!
   var deviceTypeString:NSString!
    
    
    var cellNameArray:NSArray!
    var cellValue1Array:NSMutableArray!
     var cellValue2Array:NSMutableArray!
     var cellValue3Array:NSMutableArray!
       var serverListArray:NSArray!
      var netDic:NSDictionary!
     var searchNum:Int!
     var typeNum:Int!
    
     var snOrAlias:Int!
    var plantListArray:NSMutableArray!
      var pageNum:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    self.title=root_shebei_soushuo
        pageNum=1
       
        let tap=UITapGestureRecognizer(target: self, action: #selector(keyboardHide(tap:)))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        
        self.view.backgroundColor=UIColor.white
        
           self.navigationController?.navigationBar.barTintColor=MainColor
        
      self.initUI()
            self.initUiTwo()
        
     
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
        self.searchBar.placeholder = root_shuru_soushuo_neirong
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
        button1.frame=CGRect(x: 5*NOW_SIZE, y: 4*HEIGHT_SIZE, width: 20*HEIGHT_SIZE, height:20*HEIGHT_SIZE)
        button1.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        button1.addTarget(self, action:#selector(searchDevice), for: .touchUpInside)
        view2.addSubview(button1)
        
        
        
    }
    
    
    
    func initUiTwo(){
        
        view3=UIView()
        view3.frame=CGRect(x: 0*NOW_SIZE, y: 40*HEIGHT_SIZE, width: SCREEN_Width, height: SCREEN_Height-30*HEIGHT_SIZE)
        view3.backgroundColor=UIColor.clear
        self.view.addSubview(view3)
        
        button22=UIButton()
        button22.frame=CGRect(x: 50*NOW_SIZE, y: 10*HEIGHT_SIZE, width: 220*NOW_SIZE, height:25*HEIGHT_SIZE)
        
        if (getAddress==nil)||(getAddress=="") {
          button22.setTitle("点击获取服务器地址", for: .normal)
        }else{
          button22.setTitle(getAddress as String?, for: .normal)
            addressString=getAddress
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
        view3.addSubview(button22)
        
        
       let RfSnLable=UILabel()
         RfSnLable.frame=CGRect(x: 0*NOW_SIZE, y: 40*HEIGHT_SIZE, width: SCREEN_Width, height: 40*HEIGHT_SIZE)
        RfSnLable.text=root_xuanzhe_soushuo_leixing
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
        
        var searchDeviceAddressString=""
        if UserDefaults.standard.object(forKey: "searchDeviceAddress") as? String != nil {
             searchDeviceAddressString=UserDefaults.standard.object(forKey: "searchDeviceAddress") as! String
        }
        
        
         addressLable=UILabel()
        addressLable.frame=CGRect(x: 0*NOW_SIZE, y: 420*HEIGHT_SIZE, width: SCREEN_Width, height: 20*HEIGHT_SIZE)
        addressLable.text=searchDeviceAddressString 
        addressLable.textColor=COLOR(_R: 102, _G: 102, _B: 102, _A: 1)
        addressLable.textAlignment=NSTextAlignment.center
        addressLable.font=UIFont.systemFont(ofSize: 12*HEIGHT_SIZE)
        view3.addSubview(addressLable)
        
        
    }
    
    

    
    
    
    
    func getServerURL(){
        let nameArray:NSMutableArray=[]
        let addressArray:NSMutableArray=[]
   
          self.serverListArray=UserDefaults.standard.object(forKey: "OssServerAddress") as! NSArray
        
        if self.languageType=="0" {
            for i in 0..<self.serverListArray.count {
                let allArray=self.serverListArray[i]as!NSDictionary
                let titleName=NSString(format: "%@:%@", allArray["cnName"]as!NSString,allArray["url"]as!NSString)
                nameArray.add(titleName)
                addressArray.add(allArray["url"]as!NSString)
            }
        }else{
            for i in 0..<self.serverListArray.count {
                let allArray=self.serverListArray[i]as!NSDictionary
                     let titleName=NSString(format: "%@:%@", allArray["enName"]as!NSString,allArray["url"]as!NSString)
                nameArray.add(titleName)
                addressArray.add(allArray["url"]as!NSString)
            }
        }
        
        ZJBLStoreShopTypeAlert.show(withTitle: root_xuanzhe_fuwuqi_dizhi, titles: nameArray as NSArray as! [NSString], selectIndex: {
            (selectIndex)in
       
            self.addressString=addressArray[selectIndex] as! NSString
            self.getAddress=self.addressString
             print("选择11了"+String(describing: selectIndex))
            
            let searchDeviceAddressString=String(format: "搜索服务器:%@", self.addressString)
            UserDefaults.standard.set(self.addressString, forKey: "searchDeviceAddress")
            self.addressLable.text=searchDeviceAddressString
            
        }, selectValue: {
            (selectValue)in
    
            print("选择了"+String(describing: selectValue))
            self.button22.setTitle(selectValue, for: .normal)
        }, showCloseButton: true)
        
    }
   
    
    func initTableView(){
        
       tableView=UITableView()
        let H1=30*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
           tableView.separatorStyle = UITableViewCellSeparatorStyle.none
         tableView.register(deviceFirstCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let foot=MJRefreshAutoNormalFooter(refreshingBlock: {
           
            self.pageNum=self.pageNum+1
            
            if (self.searchNum>3){
            self.initNet3()
            }else{
            self.initNet0()
            }
                
            

            //结束刷新
            self.tableView!.mj_footer.endRefreshing()
        })
       
        tableView.mj_footer=foot
        foot?.setTitle("", for: .idle)
        
    
    }
    

        
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 46*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
      //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceFirstCell
        
        let lable1=NSString(format: "%@:%@", cellNameArray[0]as!NSString,self.cellValue1Array.object(at: indexPath.row) as! CVarArg)
         let lable2=NSString(format: "%@:%@", cellNameArray[1]as!NSString,self.cellValue2Array.object(at: indexPath.row) as! CVarArg)
        cell.TitleLabel1.text=lable1 as String
         cell.TitleLabel2.text=lable2 as String

  
        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.typeNum==0)||(self.typeNum==1)||(self.typeNum==2){
                 let goView=PlantList()
        
            
            if self.typeNum==0{
                
                goView.userNameString=self.cellValue1Array.object(at: indexPath.row) as!NSString
            }else{
             
                goView.userNameString=self.cellValue2Array.object(at: indexPath.row) as!NSString
            }
            goView.netToDic=self.netDic
              goView.userListDic=self.plantListArray.object(at: indexPath.row) as! NSDictionary
                  self.navigationController?.pushViewController(goView, animated: true)
                 tableView.deselectRow(at: indexPath, animated: true)
        
        }
        
        
        if self.typeNum==3{
            let goView=deviceListViewController()
            goView.plantIdString=self.cellValue3Array.object(at: 0) as!NSString
            
            self.navigationController?.pushViewController(goView, animated: true)
        }

        if self.typeNum==4{
            let vc=deviceControlView()
            vc.deviceTypeString=self.deviceTypeString
            vc.deviceSnString=self.cellValue1Array.object(at: indexPath.row) as!NSString
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    func butttonChange(uibutton: UIButton)  {
        
         self.changeStateT(Tag: uibutton.tag)
        
 
        if uibutton.isSelected {
            uibutton.backgroundColor=UIColor.white
            uibutton.setTitleColor(MainColor, for: .normal)
             uibutton.isSelected=false
            self.title=root_shebei_soushuo
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
            let titleName2=root_dangqian_shebei_leixing
            let titleName=NSString(format: "%@:%@", titleName2,titleName1!)
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
    
        
        if (searchBar.text==nil)||(searchBar.text=="") {
            self.showToastView(withTitle: root_shuru_soushuo_leixing)
            return
        }
        if (addressString==nil)||(addressString=="") {
            self.showToastView(withTitle: root_shuru_fuwuqi_dizhi)
            return
        }
        
       var choiceBool=false
        for i in 0...6{
            let A=2000+i
            if (view3 != nil) {
                   let B1 = view3.viewWithTag(A) as! UIButton
                if B1.isSelected {
                    goNetString=String(format: "%d", A) as NSString!
                    if A==2004||A==2005||A==2006{              //具体设备接口
                        if (view4 != nil) {
                            let C1 = view4.viewWithTag(2007) as! UIButton
                            let C2 = view4.viewWithTag(2008) as! UIButton
                            if C1.isSelected==false&&C2.isSelected==false {
                                self.showToastView(withTitle: root_xuanze_xuliehao_hebieming)
                                return
                            }else{
                                if C1.isSelected==true {
                                    snOrAlias=1
                                }else {
                                    snOrAlias=2
                                }
                                
                            }
                        }
                     searchNum=i
                      self.initNet2()
                    }else{                     //电站列表接口
                     searchNum=i
                          self.initNet1()
                    }
                    
                    choiceBool=true
                }
            }
         
       
        }
    
        if choiceBool==false {
               self.showToastView(withTitle: root_xuanzhe_soushuo_leixing)
            return
        }
    

        
        
    }
   
    
    func initNet1(){
        
        self.cellValue1Array=[]
        self.cellValue2Array=[]
        self.cellValue3Array=[]
        self.plantListArray=[]
        pageNum=1
        
        if searchNum==0 {
            typeNum=0
        }else if searchNum==1 {
            typeNum=3
        }else if searchNum==2 {
            typeNum=1
        }else if searchNum==3{
            typeNum=2
        }
        
        
        self.initNet0()
    }
    
    func initNet0(){
    
            let value1=searchBar.text!
        netDic=["searchType":typeNum,"param":value1,"page":pageNum,"serverAddr":addressString]
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]! , paramarsSite: "/api/v1/search/all", sucessBlock: {(successBlock)->() in
            
            self.hideProgressView()
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/all=",jsonDate)
                
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                     UserDefaults.standard.set(self.addressString, forKey: "OssAddress")
                     let server2="http://";
                    let server=NSString(format: "%@%@", server2,self.addressString)
                          UserDefaults.standard.set(server, forKey: "server")
                  
                    
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    var plantAll:NSArray=[]
                    //获取用户列表
                    if self.typeNum==0{
                      self.cellNameArray=[root_yonghuming,root_chuanjian_shijian];
                           plantAll=objArray["userList"] as! NSArray
                        for i in 0..<plantAll.count{
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["accountName"] as!NSString)
                                   var dateString=(plantAll[i] as! NSDictionary)["createDate"] as!NSString
                            if dateString.length>11{
                               dateString=dateString.substring(to: 11) as NSString
                            }
                            
                               self.cellValue2Array.add(dateString)
                                  self.plantListArray.add(plantAll[i])
                            
                        }
                        
                    }
                    
                    //获取手机列表
                    if self.typeNum==1{
                           self.cellNameArray=[root_shoujihao,root_yonghuming];
                      plantAll=objArray["userList"] as! NSArray
                        for i in 0..<plantAll.count{
                          self.cellValue1Array.add((plantAll[i] as! NSDictionary)["phoneNum"] as!NSString)
                              self.cellValue2Array.add((plantAll[i] as! NSDictionary)["accountName"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    //获取邮箱列表
                    if self.typeNum==2{
                        self.cellNameArray=[root_youxiang,root_yonghuming];
                        plantAll=objArray["userList"] as! NSArray
                        for i in 0..<plantAll.count{
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["email"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["accountName"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    //获取电站列表
                    if self.typeNum==3{
                        self.cellNameArray=[root_dianzhanming,root_suoshu_yonghuming];
                         plantAll=objArray["plantList"] as! NSArray
               
                        for i in 0..<plantAll.count{
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["plantName"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["userAccount"] as!NSString)
                            let idString=NSString(format: "%d", (plantAll[i] as! NSDictionary)["id"] as!Int)
                            self.cellValue3Array.add(idString)
                             self.plantListArray.add(plantAll[i])
                        }
                        
                    }
                    
                    
                    if ((plantAll.count==0) && !(self.plantListArray.count==0)){
                        self.showToastView(withTitle: root_meiyou_gengduo_shuju)
                    }
                    
                    if self.plantListArray.count==1{
                        if ((self.typeNum==0)||(self.typeNum==1)||(self.typeNum==2)){
                            let goView=PlantList()
                            if self.typeNum==0{
                             goView.userNameString=self.cellValue1Array.object(at: 0) as!NSString
                            }else{
                            goView.userNameString=self.cellValue2Array.object(at: 0) as!NSString
                            }
                                goView.userListDic=self.plantListArray.object(at: 0) as! NSDictionary
                            goView.netToDic=self.netDic
                            self.navigationController?.pushViewController(goView, animated: true)
                        }
                        
                        if self.typeNum==3{
                            let goView=deviceListViewController()
                      goView.plantIdString=self.cellValue3Array.object(at: 0) as!NSString
                            
                            self.navigationController?.pushViewController(goView, animated: true)
                        }
                      
                     
                    }
                    
                    if self.plantListArray.count>1{
                        
                        if (self.view3 != nil){
                            self.view3.removeFromSuperview()
                            self.view3=nil
                        }
                        if (self.tableView == nil){
                            self.initTableView()
                        }else{
                            self.tableView.reloadData()
                        }

                    }
                    
                    
                }else{
                           self.hideProgressView()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
                   self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })
        
    }
    

    
    
    func initNet2(){
        self.cellValue1Array=[]
        self.cellValue2Array=[]
        self.cellValue3Array=[]
        self.plantListArray=[]
        pageNum=1
        typeNum=4
            
        self.initNet3()
    }
    
    
    func initNet3(){
        
        var value1=0
        var value2=""
        var value3=""
        if searchNum==4 {
            value1=0
        }else if searchNum==5 {
            value1=1
        }else if searchNum==6 {
            value1=2
        }
        if snOrAlias==1 {
            value2=searchBar.text!
        }else if snOrAlias==2 {
            value3=searchBar.text!
        }
        
        netDic=["deviceSn":value2,"alias":value3,"deviceType":value1,"serverAddr":addressString,"page":pageNum]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/device/info", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/search/info=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    self.deviceTypeString=NSString(format: "%d", value1)
                      UserDefaults.standard.set(self.addressString, forKey: "OssAddress")
                    let server2="http://";
                    let server=NSString(format: "%@%@", server2,self.addressString)
                    UserDefaults.standard.set(server, forKey: "server")
                    
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    var plantAll:NSArray = []
                    
                    let deviceType=objArray["deviceType"] as! Int
                   
                    
                    if deviceType==0 {
                      plantAll=objArray["datalogList"] as! NSArray
                    }else if deviceType==1 {
                          plantAll=objArray["invList"] as! NSArray
                    }else if deviceType==2 {
                           plantAll=objArray["storageList"] as! NSArray
                    }
                    if plantAll.count>0{
                        for i in 0..<plantAll.count{
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["serialNum"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["alias"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    if self.plantListArray.count==1 {
                        let vc=deviceControlView()
                        vc.deviceTypeString=NSString(format: "%d", deviceType)
                        vc.deviceSnString=(plantAll[0] as! NSDictionary)["serialNum"] as!NSString
                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                    
                    if self.plantListArray.count>1{
                           self.cellNameArray=["序列号","别名"];
                        if (self.view3 != nil){
                            self.view3.removeFromSuperview()
                            self.view3=nil
                        }
                        if (self.tableView == nil){
                            self.initTableView()
                        }else{
                            self.tableView.reloadData()
                        }
                        
                    }
                    
                    
                }else{
                     self.hideProgressView()
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
                   self.hideProgressView()
            self.showToastView(withTitle: root_Networking)
        })

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if (tableView != nil){
            tableView.removeFromSuperview()
            tableView=nil
            self.title=root_shebei_soushuo
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
