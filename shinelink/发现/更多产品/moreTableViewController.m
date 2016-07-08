//
//  moreTableViewController.m
//  shinelink
//
//  Created by sky on 16/4/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "moreTableViewController.h"
#import "moreCell.h"
#import "productViewController.h"
#import "ProductData.h"

@interface moreTableViewController ()
@property (nonatomic, strong) NSMutableArray *name;
@property (nonatomic, strong) NSMutableArray *feature;
@property (nonatomic, strong) NSMutableArray *outline;
@property (nonatomic, strong) NSMutableArray *paramsName;
@property (nonatomic, strong) NSMutableArray *imageName;
@property (nonatomic, strong) NSMutableArray *imageHead;
@property (nonatomic, strong) NSMutableArray *identifying;
@property (nonatomic, strong) NSMutableArray *imageNameArray;
@property (nonatomic, strong) NSMutableArray *imageNameNext;
@property (nonatomic, strong) NSMutableArray *imageDataArray;
@property (nonatomic, strong) NSArray *allArray;
@property (nonatomic, strong) CoreDataManager *manager;
@property (nonatomic, strong) ProductData *productData;

  @property (nonatomic, strong)  NSString *languageValue;
@end

@implementation moreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name=[NSMutableArray array];
    _feature=[NSMutableArray array];
    _outline=[NSMutableArray array];
    _paramsName=[NSMutableArray array];
    _imageName=[NSMutableArray array];
    _imageHead=[NSMutableArray array];
      _identifying=[NSMutableArray array];
        _imageNameArray=[NSMutableArray array];
     _imageNameNext=[NSMutableArray array];
       _imageDataArray=[NSMutableArray array];
    
          self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
     _manager=[CoreDataManager sharedCoreDataManager];
    
    [self initData];
}


-(void)initData{
  
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];

    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }else if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

     [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"language":_languageValue} paramarsSite:@"/newProductAPI.do?op=getProductList" sucessBlock:^(id content) {
        
        NSLog(@"getMoreProductList: %@", content);
   [self hideProgressView];
        if (content) {
            
            _allArray=[NSArray arrayWithArray:content];
            
            for (int i=0; i<_allArray.count; i++) {
                NSString *productImage=[NSString stringWithString:_allArray[i][@"productImage"]];
                [_imageNameArray addObject:productImage];
            }
            
            
            [self getData];
    
            
        
        }
        
    } failure:^(NSError *error) {
          [self hideProgressView];
    }];

    
   
}


-(void)getAllData{

    for (int i=0; i<_name.count; i++) {
         _productData=[NSEntityDescription insertNewObjectForEntityForName:@"ProductData" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
        _productData.feature=_feature[i];
        _productData.outline=_outline[i];
        _productData.productName=_name[i];
        _productData.technologyParams=_paramsName[i];
         _productData.productImage=_imageNameNext[i];
         _productData.identifying=_identifying[i];
         _productData.imageData=_imageDataArray[i];
        
    }
    
 NSError *error = nil;
    BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }

    
    

}



-(void)getData{
    
    
 NSError *error = nil;
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"ProductData" inManagedObjectContext:_manager.managedObjContext];
    [request2 setEntity:entity2];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:NO];
    NSArray *sortDescriptions2 = [[NSArray alloc] initWithObjects:sortDescriptor2, nil];
    [request2 setSortDescriptors:sortDescriptions2];

    NSArray *ProductDataAll = [_manager.managedObjContext executeFetchRequest:request2 error:&error];
    
        NSMutableArray *sameArray=[NSMutableArray array];
    
    for (int i=0; i<ProductDataAll.count; i++) {
    ProductData *AllData1=ProductDataAll[i];
     [sameArray addObject:AllData1.productImage];
    }
    
       NSString *getSame;
    
    for (int i=0; i<sameArray.count; i++) {
        
        if ( ![sameArray containsObject:_imageNameArray[i]]) {
            getSame=@"0";
        }
    }
    
    if (sameArray.count==0) {
         getSame=@"0";
    }
    _imageNameArray=[NSMutableArray new];
    
    if ([getSame isEqualToString:@"0"]) {
        for (int i=0; i<_allArray.count; i++) {
            [_name addObject:_allArray[i][@"productName"]];
            [_feature addObject:_allArray[i][@"feature"]];
            [_outline addObject:_allArray[i][@"outline"]];
            [_paramsName addObject:_allArray[i][@"technologyParams"]];
            [_imageName addObject:_allArray[i][@"productName"]];
            [_imageNameNext addObject:_allArray[i][@"productImage"]];
            
            NSString *C=[NSString stringWithFormat:@"%@",_allArray[i][@"identifying"]];
            [_identifying addObject:C];
            
            NSString *productImage=[NSString stringWithString:_allArray[i][@"productImage"]];
            
            [_imageNameArray addObject:productImage];
        }

        [self.tableView reloadData];
        [self getImage];
        
    }else{
    
    
    
    for (int i=0; i<ProductDataAll.count; i++) {
        
        ProductData *AllData=ProductDataAll[i];
        [_name addObject:AllData.productName];
        [_feature addObject:AllData.feature];
        [_outline addObject:AllData.outline];
        [_paramsName addObject:AllData.technologyParams];
        [_imageName addObject:AllData.productName];
        [_imageNameNext addObject:AllData.productImage];
        
        [_identifying addObject:AllData.identifying];
        
        [_imageNameArray addObject:AllData.productImage];
        
          UIImage * resultImage;
        resultImage = [UIImage imageWithData:(NSData*)AllData.imageData];
        [_imageHead addObject:resultImage];
    }
    
    [self.tableView reloadData];
    }

}




-(void)getImage{
    if (_imageNameArray.count==_name.count) {
        
        for (int i=0; i<_imageNameArray.count; i++) {
            NSString *imageURL=[NSString stringWithFormat:@"%@/%@",HEAD_URL,_imageNameArray[i]];
            UIImage * resultImage;
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            
            if (data!= nil) {
                resultImage = [UIImage imageWithData:data];
                [_imageHead addObject:resultImage];
                [_imageDataArray addObject:data];
                
                if (_imageNameArray.count==_imageHead.count) {
                    [self getAllData];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }else{
                [self.tableView reloadData];
            }
        }
    }

}







- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _name.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    moreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[moreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (_name.count==_imageHead.count) {
         [cell.typeImageView setImage:_imageHead[indexPath.row]];
    }
   
    
    
       cell.name.text=_name[indexPath.row];
  NSString *connentText=[NSString stringWithFormat:@"%@",_outline[indexPath.row]];
  // NSString *connentText=@"专为小型商业系统设计\n内置变压器\n隔离电网\n并提供通用的400V输出\n可直接低压并网";
     cell.connent.text=connentText;
    
   // _identifying[indexPath.row]=@"1";
    
    if ([_identifying[indexPath.row]isEqualToString:@"1"]) {
        cell.image.frame=CGRectMake(SCREEN_Width-30*NOW_SIZE, 10*HEIGHT_SIZE, 30*NOW_SIZE,30*HEIGHT_SIZE );
       cell.image.image = IMAGE(@"product2.jpg");
        cell.imageLog.frame=CGRectMake(SCREEN_Width-30*NOW_SIZE, 10*HEIGHT_SIZE, 30*NOW_SIZE,30*HEIGHT_SIZE );
        cell.imageLog.text=root_new;
        cell.imageLog.font=[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        
    }else if(([_identifying[indexPath.row]isEqualToString:@"0"])){
    cell.image.frame=CGRectMake(SCREEN_Width-45*NOW_SIZE, 10*HEIGHT_SIZE, 35*NOW_SIZE,20*HEIGHT_SIZE );
          cell.image.image = IMAGE(@"product.jpg");
         cell.imageLog.frame=CGRectMake(SCREEN_Width-45*NOW_SIZE, 10*HEIGHT_SIZE, 35*NOW_SIZE,20*HEIGHT_SIZE );
         cell.imageLog.text=root_tuijian;
        
    }
  
//    if (indexPath.row==1) {
//        [self getImage];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108*HEIGHT_SIZE;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    productViewController *page4 = [[productViewController alloc] init];
    page4.name2=_name[indexPath.row];
       page4.feature2=_feature[indexPath.row];
       page4.outline2=_outline[indexPath.row];
    
    if (_name.count==_imageHead.count) {
       page4.imageHead2=_imageHead[indexPath.row];
    }
    page4.imageName=_imageNameNext[indexPath.row];
  
    page4.paramImage=_paramsName[indexPath.row];
    page4.imageArray=[NSMutableArray arrayWithObject:_imageHead[indexPath.row]];
    [self.navigationController pushViewController:page4 animated:NO];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
