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
      var cellValue6Array:NSMutableArray!
    var questionOrOrder:Int!
    
    
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
        questionOrOrder=1
        
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
        button1.addTarget(self, action:#selector(initNet1), for: .touchUpInside)
        view2.addSubview(button1)
        
        let buttonView1=uibuttonView0()
        buttonView1.frame=CGRect(x: 0*NOW_SIZE, y: 30*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
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
        self.view3.frame=CGRect(x: 0*NOW_SIZE, y: 60*HEIGHT_SIZE, width: SCREEN_Width, height: 52*HEIGHT_SIZE)
        view3.backgroundColor=UIColor.clear
        self.view.addSubview(view3)
        
        let buttonView=uibuttonView0()
        buttonView.frame=CGRect(x: 0*NOW_SIZE, y: 0*HEIGHT_SIZE, width: SCREEN_Width, height: 30*HEIGHT_SIZE)
        buttonView.typeNum=3
        buttonView.isUserInteractionEnabled=true
        buttonView.backgroundColor=UIColor.white
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
        
        let view00=UIView()
        view00.frame=CGRect(x: 10*NOW_SIZE, y: 30*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 2*HEIGHT_SIZE)
        view00.backgroundColor=backgroundGrayColor
        view3.addSubview(view00)
        
        let view0=UIView()
        view0.frame=CGRect(x: 10*NOW_SIZE, y: 50*HEIGHT_SIZE, width: 300*NOW_SIZE, height: 2*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        view3.addSubview(view0)

    }
    
    func tableViewReload(info:NSNotification){
        
        let  dic=info.userInfo as Any as!NSDictionary
        let Tag=dic.object(forKey: "tag") as! Int
        let array1=["全部问题","待处理","待跟进","处理中","已处理"]
        let array2=["全部工单","待接收","待服务","已完成"]
        if Tag==2000 {
               self.initButton(buttonArray: array1 as NSArray, name1: array1[0] as NSString, name2: "")
            questionOrOrder=1
              statusInt=10
        }
        if Tag==2001 {
             self.initButton(buttonArray: array2 as NSArray, name1: array2[0] as NSString, name2: "")
               questionOrOrder=2
             statusInt=0
        }
    
        if questionOrOrder==1 {
            if Tag==4000 {
                statusInt=10
                lable1.text=array1[0]
            }else if Tag==4001 {
                statusInt=0
                     lable1.text=array1[1]
            }else if Tag==4002 {
                statusInt=3
                  lable1.text=array1[2]
            }else if Tag==4003 {
                statusInt=1
                  lable1.text=array1[3]
            }else if Tag==4004 {
                statusInt=2
                   lable1.text=array1[4]
            }
            self.initNet1()
        }
        
        if questionOrOrder==2 {
            if Tag==4000 {
                statusInt=0
                lable1.text=array2[0]
            }else if Tag==4001 {
                statusInt=2
                   lable1.text=array2[1]
            }else if Tag==4002 {
                statusInt=3
                  lable1.text=array2[2]
            }else if Tag==4003 {
                statusInt=4
                  lable1.text=array2[3]
            }
            self.initNet1()
        }
        

    }

    
    
    func initTableView(){
        
        tableView=UITableView()
        let H1=112*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(listTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
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
        
        return 60*HEIGHT_SIZE
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! listTableViewCell
        
        if  questionOrOrder==1 {
            if cellValue4Array[indexPath.row] as! Int==0 {
                cell.coverImageView.backgroundColor=COLOR(_R: 227, _G: 74, _B: 33, _A: 1)
                cell.imageLabel.text=root_daichuli
            }else if cellValue4Array[indexPath.row] as! Int==1 {
                cell.coverImageView.backgroundColor=COLOR(_R: 94, _G: 195, _B: 53, _A: 1)
                cell.imageLabel.text=root_chulizhong
            }else if cellValue4Array[indexPath.row] as! Int==2 {
                cell.coverImageView.backgroundColor=COLOR(_R: 157, _G: 157, _B: 157, _A: 1);
                cell.imageLabel.text=root_yichuli;
            }else if cellValue4Array[indexPath.row] as! Int==3 {
                cell.coverImageView.backgroundColor=COLOR(_R: 227, _G: 164, _B: 33, _A: 1);
                cell.imageLabel.text=root_daigengjin;
            }
        
        }else if  questionOrOrder==2 {
            if cellValue4Array[indexPath.row] as! Int==2 {
                cell.coverImageView.backgroundColor=COLOR(_R: 227, _G: 74, _B: 33, _A: 1)
                cell.imageLabel.text="待接收"
            }else if cellValue4Array[indexPath.row] as! Int==3 {
                cell.coverImageView.backgroundColor=COLOR(_R: 94, _G: 195, _B: 53, _A: 1)
                cell.imageLabel.text="服务中"
            }else if cellValue4Array[indexPath.row] as! Int==4 {
                cell.coverImageView.backgroundColor=COLOR(_R: 157, _G: 157, _B: 157, _A: 1);
                cell.imageLabel.text="已完成"
            }
            
        }

        
        
        cell.lineType="1"
                    cell.titleLabel.text = self.cellValue1Array.object(at: indexPath.row) as? String
                    cell.contentLabel.text =  self.cellValue3Array.object(at: indexPath.row) as? String
                    cell.timeLabel.text=self.cellValue2Array.object(at: indexPath.row) as? String
 
        let view0=UIView()
        view0.frame=CGRect(x: 2*NOW_SIZE, y: 58*HEIGHT_SIZE, width: SCREEN_Width-4*NOW_SIZE, height: 2*HEIGHT_SIZE)
        view0.backgroundColor=backgroundGrayColor
        cell.contentView.addSubview(view0)
        
  
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  questionOrOrder==1 {
            let vc=ossQuetionDetail()
            let id=NSString(format: "%d", self.cellValue5Array.object(at: indexPath.row) as! Int)
            vc.qusetionId=id as String!
            vc.serverUrl=self.cellValue6Array.object(at: indexPath.row) as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }else  if  questionOrOrder==2 {
            let vc=orderFirst()
              let id=NSString(format: "%d", self.cellValue5Array.object(at: indexPath.row) as! Int)
             vc.orderID=id as String!
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    
    
    func initNet1(){
        
        pageNum=0
        self.cellValue1Array=[]
        self.cellValue2Array=[]
        self.cellValue3Array=[]
        self.cellValue4Array=[]
        self.cellValue5Array=[]
        self.cellValue6Array=[]
       self.plantListArray=[]
        
        if  questionOrOrder==1 {
             self.initNet0()
        }else if questionOrOrder==2 {
            self.initNet2()
        }
        
       
    }

    

    //MARK: - 网络层
    
    
     func initNet2(){
    
    contentString=searchBar.text! as NSString
    
    netDic=["content":contentString,"status":statusInt,"page":pageNum]
    
    self.showProgressView()
    BaseRequest.request(withMethodResponseStringResult: OSS_HEAD_URL, paramars:netDic as Dictionary, paramarsSite: "/api/v1/workOrder/work/list", sucessBlock: {(successBlock)->() in
    self.hideProgressView()
    
    let data:Data=successBlock as! Data
    
    let jsonDate0=try? JSONSerialization.jsonObject(with: data, options:[])
    
    if (jsonDate0 != nil){
    let jsonDate=jsonDate0 as! Dictionary<String, Any>
    print("/api/v1/serviceQuestion/question/list=",jsonDate)
    // let result:NSString=NSString(format:"%s",jsonDate["result"] )
    let result1=jsonDate["result"] as! Int
    
    if result1==1 {
    let objArray=jsonDate["obj"] as! Dictionary<String, Any>
    let questionAll=objArray["ticketList"] as! NSArray
      
        
    for i in 0..<questionAll.count{
    self.cellValue1Array.add((questionAll[i] as! NSDictionary)["title"] as!NSString)
    self.cellValue2Array.add((questionAll[i] as! NSDictionary)["applicationTime"] as!NSString)
        var cellValue3Array1:NSString
        var cellValue3Array2:NSString
        if (((((questionAll[i] as! NSDictionary)["groupName"] as AnyObject).isEqual(NSNull.init())) == false)) {
          cellValue3Array1=((questionAll[i] as! NSDictionary)["groupName"] as!NSString)
        }else{
        cellValue3Array1=""
        }
        
        if (((((questionAll[i] as! NSDictionary)["address"] as AnyObject).isEqual(NSNull.init())) == false)) {
            cellValue3Array2=((questionAll[i] as! NSDictionary)["address"] as!NSString)
        }else{
            cellValue3Array2=""
        }
        
        let contentString=NSString(format: "%@:%@", cellValue3Array1, cellValue3Array2)
        self.cellValue3Array.add(contentString)
    self.cellValue4Array.add((questionAll[i] as! NSDictionary)["status"] as! Int)
    self.cellValue5Array.add((questionAll[i] as! NSDictionary)["id"] as! Int)

    self.plantListArray.add((questionAll[i] as! NSDictionary))
    }
    
        let lableText=NSString(format: "%d/%d", self.plantListArray.count,objArray["total"] as! Int)
        self.lable2.text=lableText as String
        
    if self.plantListArray.count==0{
    if (self.tableView != nil){
    self.tableView.removeFromSuperview()
    self.tableView=nil
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
    self.hideProgressView()
    self.showToastView(withTitle: root_Networking)
    })
    
    }
    
    
    func initNet0(){
        
    contentString=searchBar.text! as NSString
        
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
     let objArray=jsonDate["obj"] as! Dictionary<String, Any>
                   let questionAll=objArray["questionList"] as! NSArray
                    for i in 0..<questionAll.count{
       self.cellValue1Array.add((questionAll[i] as! NSDictionary)["title"] as!NSString)
                self.cellValue2Array.add((questionAll[i] as! NSDictionary)["lastTime"] as!NSString)
                        let replyArray=((questionAll[i] as! NSDictionary)["serviceQuestionReplyBean"]) as! NSArray
                        if replyArray.count>0{
                            if (((replyArray[0] as AnyObject).isEqual(NSNull.init())) == false) {
                                let replyDic=replyArray[0] as! Dictionary<String, Any>
                                let contentString=NSString(format: "%@:%@", (replyDic["userName"])as! NSString, (replyDic["message"])as! NSString)
                                self.cellValue3Array.add(contentString)
                            }else{
                            self.cellValue3Array.add((questionAll[i] as! NSDictionary)["content"] as!NSString)
                            }
                        }else{
                          self.cellValue3Array.add((questionAll[i] as! NSDictionary)["content"] as!NSString)
                        }
                        
                             self.cellValue4Array.add((questionAll[i] as! NSDictionary)["status"] as! Int)
                          self.cellValue5Array.add((questionAll[i] as! NSDictionary)["id"] as! Int)
                         self.cellValue6Array.add((questionAll[i] as! NSDictionary)["serverUrl"] as! NSString)
                        
                          self.plantListArray.add((questionAll[i] as! NSDictionary))
                    }
                    
                 
                    let lableText=NSString(format: "%d/%d", self.plantListArray.count,objArray["total"] as! Int)
                    self.lable2.text=lableText as String
                    
                    if self.plantListArray.count==0{
                        if (self.tableView != nil){
                        self.tableView.removeFromSuperview()
                            self.tableView=nil
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
             self.hideProgressView()
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
