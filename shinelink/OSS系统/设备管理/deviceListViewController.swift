
//
//  deviceListViewController.swift
//  ShinePhone
//
//  Created by sky on 17/5/20.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit


class deviceListViewController: RootViewController,UITableViewDataSource,UITableViewDelegate {
   var view1:UIView!
       var tableView:UITableView!
    var cellNameArray:NSMutableArray!
    var cellValue0Array:NSMutableArray!
    var cellValue1Array:NSMutableArray!
    var cellValue2Array:NSMutableArray!
    var cellValue3Array:NSMutableArray!
        var plantListArray:NSMutableArray!
       var cellValue4Array:NSMutableArray!
     var pageNum:Int!
   var netDic:NSDictionary!
    
    var AllValue1Array:NSArray!
    var AllValue2Array:NSArray!
    var AllValue3Array:NSArray!
    var AllValue4Array:NSArray!
       var plantIdString:NSString!
       var deviceTypeString:NSString!
    

    override func viewWillAppear(_ animated: Bool) {
        pageNum=0
        
            self.navigationController?.navigationBar.barTintColor=MainColor
        self.initNet1()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
deviceTypeString="1"
      self.initUI()
    }

    func initUI(){

        

       let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=0
        buttonView.goToNetNum=1
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=backgroundGrayColor
        buttonView.buttonArray=[root_caijiqi,root_niBianQi,root_chuNengJi]
        buttonView.initUI()
        self.view .addSubview(buttonView)
        
        
        let NotifyChatMsgRecv = NSNotification.Name(rawValue:"ReLoadTableView1")
        NotificationCenter.default.addObserver(self, selector:#selector(tableViewReload(info:)),
                                               name: NotifyChatMsgRecv, object: nil)
        

      
        
    }
  
    
    func initTableView(){
        
        tableView=UITableView()
        let H1=30*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
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
    
    func initNet1(){
        
        self.cellValue1Array=[]
        self.cellValue2Array=[]
        self.cellValue3Array=[]
          self.cellValue4Array=[]
        self.plantListArray=[]
        cellValue0Array=[]
        cellNameArray=[]
        
        self.initNet0()
    }
    
    func initNet0(){
    
        
        
        
        netDic=["plantId":plantIdString,"deviceType":deviceTypeString,"page":pageNum]
        self.showProgressView()
        BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars: netDic as! [AnyHashable : Any]!, paramarsSite: "/api/v1/device/list", sucessBlock: {(successBlock)->() in
             self.hideProgressView()
    // cellNameArray=["序列号:","状态:","所属采集器序列号:","采集器类型:","逆变器型号:"];
            let data:Data=successBlock as! Data
            
            let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
            
            if (jsonDate0 != nil){
                let jsonDate=jsonDate0 as! Dictionary<String, Any>
                print("/api/v1/device/info",jsonDate)
                // let result:NSString=NSString(format:"%s",jsonDate["result"] )
                let result1=jsonDate["result"] as! Int
                
                if result1==1 {
                    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                    
                    var plantAll:NSArray=[]
                    
                    if self.deviceTypeString=="0"{
                        plantAll=objArray["datalogList"] as! NSArray
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["alias"] as!NSString)
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["serialNum"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["lost"] as!Bool)
                            self.cellValue3Array.add((plantAll[i] as! NSDictionary)["clientUrl"] as!NSString)
                            self.cellValue4Array.add((plantAll[i] as! NSDictionary)["deviceType"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    if self.deviceTypeString=="1"{
                        plantAll=objArray["invList"] as! NSArray
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["alias"] as!NSString)
                             self.cellValue1Array.add((plantAll[i] as! NSDictionary)["serialNum"] as!NSString)
                                self.cellValue2Array.add((plantAll[i] as! NSDictionary)["lost"] as!Bool)
                               self.cellValue3Array.add((plantAll[i] as! NSDictionary)["dataLogSn"] as!NSString)
                            self.cellValue4Array.add((plantAll[i] as! NSDictionary)["modelText"] as!NSString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                
                    if self.deviceTypeString=="2"{
                        plantAll=objArray["storageList"] as! NSArray
                        for i in 0..<plantAll.count{
                            self.cellValue0Array.add((plantAll[i] as! NSDictionary)["alias"] as!NSString)
                            self.cellValue1Array.add((plantAll[i] as! NSDictionary)["serialNum"] as!NSString)
                            self.cellValue2Array.add((plantAll[i] as! NSDictionary)["lost"] as!Bool)
                            self.cellValue3Array.add((plantAll[i] as! NSDictionary)["dataLogSn"] as!NSString)
                            let Type=(plantAll[i] as! NSDictionary)["deviceType"] as!Int
                            var typeString:NSString=""
                            if Type==0{
                            typeString="SP2000"
                            }else if Type==1{
                             typeString="SP3000"
                            }else if Type==2{
                                 typeString="SPF5000"
                            }
                            self.cellValue4Array.add(typeString)
                            self.plantListArray.add(plantAll[i])
                        }
                    }
                    
                    
                    if self.plantListArray.count>0{
                        
                        if (self.tableView == nil){
                            self.initTableView()
                        }else{
                            self.tableView.reloadData()
                        }

                    }
                    
                    
                }else{
                    if (self.tableView != nil){
                     self.tableView.removeFromSuperview()
                        self.tableView=nil
                    }
                    
                    self.showToastView(withTitle: jsonDate["msg"] as! String!)
                }
                
            }
            
        }, failure: {(error) in
            self.showToastView(withTitle: root_Networking)
        })

    }
    
    func tableViewReload(info:NSNotification){

        let  dic=info.userInfo as Any as!NSDictionary
        let Tag=dic.object(forKey: "tag") as! Int
        if Tag==2000 {
              deviceTypeString="0"
          
        }
        if Tag==2001 {
   deviceTypeString="1"
        }
        if Tag==2002{
   deviceTypeString="2"
        }
          pageNum=0
       self.initNet1()
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
        
        if deviceTypeString=="0" {
              cellNameArray=[root_xunliehao,root_zhuantai,root_ip_he_duankou,root_leixing];
        }else if deviceTypeString=="1"{
          cellNameArray=[root_xunliehao,root_zhuantai,root_suoshu_caijiqi,root_xinghao];
        }else if deviceTypeString=="2"{
            cellNameArray=[root_xunliehao,root_zhuantai,root_suoshu_caijiqi,root_xinghao];
        }
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as!deviceListCell
        
        let lable1=NSString(format: "%@:%@", cellNameArray[0]as!NSString,cellValue1Array[indexPath.row]as!NSString)
     
        var lable22:NSString
        if (cellValue2Array[indexPath.row]as!Bool)==true {
            lable22 = root_lixian as NSString
        }else{
          lable22 = root_zaixian as NSString
        }
           let lable2=NSString(format: "%@:%@", cellNameArray[1]as!NSString, lable22)
        let  lable3=NSString(format: "%@:%@", cellNameArray[2]as!NSString,cellValue3Array[indexPath.row]as!NSString)
         let  lable4=NSString(format: "%@:%@", cellNameArray[3]as!NSString,cellValue4Array[indexPath.row]as!NSString)

        
       
         cell.TitleLabel0.text=cellValue0Array[indexPath.row] as? String
        
        cell.TitleLabel1.text=lable1 as String
        cell.TitleLabel2.text=lable2 as String
         cell.TitleLabel3.text=lable3 as String?
            cell.TitleLabel4.text=lable4 as String?
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let CELL=cellValue1Array[indexPath.row] as! NSString

        let goView=deviceControlView()
        
        goView.deviceTypeString=self.deviceTypeString
        goView.deviceSnString=CELL
        
        self.navigationController?.pushViewController(goView, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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
