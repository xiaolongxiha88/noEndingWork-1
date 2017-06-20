//
//  ossServerFirst.swift
//  ShinePhone
//
//  Created by sky on 17/5/15.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class ossServerFirst: RootViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {

    var searchBar:UISearchBar!
    var view1:UIView!
    var button1:UIButton!
    var view2:UIView!
    var lable1:UILabel!
    var lable2:UILabel!
     var view3:UIView!
       var netDic:NSDictionary!
      var statusInt:Int!
    var contentString:NSString!
       var pageNum:Int!
     var tableView:UITableView!
    var cellNameArray:NSMutableArray!
    var cellValue0Array:NSMutableArray!
    var cellValue1Array:NSMutableArray!
    var cellValue2Array:NSMutableArray!
    var cellValue3Array:NSMutableArray!
    var plantListArray:NSMutableArray!
    var cellValue4Array:NSMutableArray!
    var cellValue5Array:NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap=UITapGestureRecognizer(target: self, action: #selector(keyboardHide(tap:)))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        
        let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView")
        NotificationCenter.default.addObserver(self, selector:#selector(tableViewReload(info:)),
                                               name: NotifyChatMsgRecv, object: nil)
        
        if statusInt == nil {
        statusInt=10
        }
        contentString=""
        pageNum=0
        
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
        button1.frame=CGRect(x: 5*NOW_SIZE, y: 4*HEIGHT_SIZE, width: 22*HEIGHT_SIZE, height:20*HEIGHT_SIZE)
        button1.setBackgroundImage(UIImage(named: "icon_search.png"), for: .normal)
        // buttonOne.setTitle(root_finish, for: .normal)
        button1.addTarget(self, action:#selector(searchDevice), for: .touchUpInside)
        view2.addSubview(button1)
        
        let buttonView1=uibuttonView0()
        buttonView1.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView1.typeNum=1
        buttonView1.isUserInteractionEnabled=true
        buttonView1.backgroundColor=backgroundGrayColor
        buttonView1.buttonArray=["问题","工单"]
        buttonView1.initUI()
         self.view.addSubview(buttonView1)
        
        self.initButton(buttonArray: ["全部问题","待处理","待跟进","处理中","已处理"], name1: "全部问题", name2: "数量:111个")
        
        self.initNet1()
    }
    
    func initButton(buttonArray:NSArray,name1:NSString,name2:NSString){
        
        if view3 != nil {
            view3.removeFromSuperview()
            view3=nil
        }
        
        view3=UIView()
        self.view3.frame=CGRect(x: 0*NOW_SIZE, y: 30*HEIGHT_SIZE, width: SCREEN_Width, height: 52*HEIGHT_SIZE)
        view3.backgroundColor=UIColor.clear
        self.view.addSubview(view3)
        
        let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=3
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=buttonArray
        buttonView.initUI()
       view3.addSubview(buttonView)
        
        lable1=UILabel()
        lable1.frame=CGRect(x: 10*NOW_SIZE, y: 30*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
        lable1.text=name1 as String
        lable1.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        lable1.textAlignment=NSTextAlignment.left
        lable1.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        view3.addSubview(lable1)
        
        lable2=UILabel()
        lable2.frame=CGRect(x: 160*NOW_SIZE, y: 30*HEIGHT_SIZE, width: 150*NOW_SIZE, height: 20*HEIGHT_SIZE)
        lable2.text=name2 as String
        lable2.textColor=COLOR(_R: 154, _G: 154, _B: 154, _A: 1)
        lable2.textAlignment=NSTextAlignment.right
        lable2.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        view3.addSubview(lable2)
        
        let view0=UIView()
        view0.frame=CGRect(x: 10*NOW_SIZE, y: 50*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 2*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        view3.addSubview(view0)

    }
    
    func tableViewReload(info:NSNotification){
        
        let  dic=info.userInfo as Any as!NSDictionary
        let Tag=dic.object(forKey: "tag") as! Int
        if Tag==2000 {
               self.initButton(buttonArray: ["全部问题","待处理","待跟进","处理中","已处理"], name1: "全部问题", name2: "数量:111个")
        }
        if Tag==2001 {
             self.initButton(buttonArray: ["全部工单","待接收","待服务","已完成"], name1: "全部工单", name2: "数量:111个")
        }
    
    }

    
    
    func initTableView(){
        
        tableView=UITableView()
        let H1=82*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: 0, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(deviceListCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let foot=MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.pageNum=self.pageNum+1
            self.initNet0()
            
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
        return cellValue1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        cellNameArray=["所属用户:","所属电站:","所属代理商:","状态:"];
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceListCell
        
        let lable1=NSString(format: "%@%@", cellNameArray[0]as!NSString,cellValue1Array[indexPath.row]as!NSString)
        
        let lable41 = cellValue4Array[indexPath.row]as!NSString
        var lable42:NSString
        if lable41=="1" {
            lable42="掉线"
        }else{
            lable42="在线"
        }
        
        let lable4=NSString(format: "%@%@", cellNameArray[3]as!NSString,lable42)
        let  lable2=NSString(format: "%@%@", cellNameArray[1]as!NSString,cellValue2Array[indexPath.row]as!NSString)
        let  lable3=NSString(format: "%@%@", cellNameArray[2]as!NSString,cellValue3Array[indexPath.row]as!NSString)
        
        
        
        cell.TitleLabel0.text=cellValue0Array[indexPath.row] as? String
        
        cell.TitleLabel1.text=lable1 as String
        cell.TitleLabel2.text=lable2 as String
        cell.TitleLabel3.text=lable3 as String?
        cell.TitleLabel4.text=lable4 as String?
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let CELL=cellValue5Array[indexPath.row] as! NSString
        
        let goView=deviceControlView()
        goView.netType=1
     
        goView.deviceSnString=CELL
        
        self.navigationController?.pushViewController(goView, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    
    
    func initNet1(){
        
//        self.cellValue1Array=[]
//        self.cellValue2Array=[]
//        self.cellValue3Array=[]
//        self.cellValue4Array=[]
//        self.cellValue5Array=[]
//        self.plantListArray=[]
//        cellValue0Array=[]
//        cellNameArray=[]
        
        self.initNet0()
    }

    
    
    
    func searchDevice(){
    
    }
    
    
    //MARK: - 网络层
    
    func initNet0(){
        
netDic=["content":contentString,"status":statusInt,"page":pageNum]
        
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:netDic as Dictionary, paramarsSite: "/api/v1/serviceQuestion/question/list", sucessBlock: {(successBlock)->() in
            self.hideProgressView()
            
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/serviceQuestion/question/list=",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! NSArray
                    for i in 0..<objArray.count{

                        
                    }
                    
                    
                }else{
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
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
