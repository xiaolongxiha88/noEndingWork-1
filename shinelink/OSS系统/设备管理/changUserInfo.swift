//
//  changUserInfo.swift
//  ShinePhone
//
//  Created by sky on 17/6/17.
//  Copyright © 2017年 sky. All rights reserved.
//

import UIKit

class changUserInfo: RootViewController,UITableViewDataSource,UITableViewDelegate {

     var cellNameArray:NSArray!
      var cellvalueArray:NSArray!
      var tableView:UITableView!
    var userListDic:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.view.backgroundColor=MainColor
        
        cellNameArray=["修改真实姓名","修改邮箱","修改手机号","修改时区","修改公司名称","重置密码"]
        cellvalueArray=[userListDic["activeName"] as! NSString,userListDic["email"] as! NSString,userListDic["phoneNum"] as! NSString,userListDic["timeZone"] as! Int,userListDic["company"] as! NSString,""]
        self.initUI()
    }

    
    
    func initUI(){
        tableView=UITableView()
        let H1=0*HEIGHT_SIZE
        tableView.frame=CGRect(x: 0, y: H1, width: SCREEN_Width, height: SCREEN_Height-H1)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=MainColor
        tableView.separatorColor=UIColor.white;
        tableView.tableFooterView = UIView.init(frame: .zero);
        // tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        if(tableView.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            tableView.layoutMargins = UIEdgeInsets.zero;
        }
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset))
        {
            tableView.separatorInset =  UIEdgeInsets.zero;
        }
        self.view.addSubview(tableView)
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50*HEIGHT_SIZE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let  cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell");
        
        let cellId = "default"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell (style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
        }
        cell?.backgroundColor=MainColor
        cell?.textLabel?.text = cellNameArray[indexPath.row] as? String
       
       cell?.detailTextLabel?.text=cellvalueArray[indexPath.row] as? String
        if indexPath.row==3 {
              cell?.detailTextLabel?.text=String(format: "%d", cellvalueArray[indexPath.row] as! Int)
        }
        
        cell?.textLabel?.font=UIFont.systemFont(ofSize: 14*HEIGHT_SIZE)
        cell?.detailTextLabel?.font=UIFont.systemFont(ofSize: 10*HEIGHT_SIZE)
        cell?.textLabel?.textColor=UIColor.white
          cell?.detailTextLabel?.textColor=UIColor.white
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        
        if(cell!.responds(to: #selector(setter: UIView.layoutMargins)))
        {
            cell!.layoutMargins = UIEdgeInsets.zero;
        }
        if cell!.responds(to: #selector(setter: UITableViewCell.separatorInset))
        {
            cell!.separatorInset =  UIEdgeInsets.zero;
        }
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row==0 || indexPath.row==1 || indexPath.row==4{
            let goView=datalogerControlTwo()
            goView.lableName=cellNameArray[indexPath.row] as! NSString
            goView.typeNum = NSString(format: "%d", indexPath.row)
 
            self.navigationController?.pushViewController(goView, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }else if indexPath.row==2{

            
        }else if indexPath.row==3{
          
        }
        
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
