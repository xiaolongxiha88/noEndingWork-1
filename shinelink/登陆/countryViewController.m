//
//  countryViewController.m
//  shinelink
//
//  Created by sky on 16/2/23.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "countryViewController.h"
#import "AddressPickView.h"
#import "loginViewController.h"
#import "registerViewController.h"
#import "SNLocationManager.h"
#import "AnotherSearchViewController.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "inputLocationView.h"

@interface countryViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *label2;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSMutableArray *countryArray;
@property(nonatomic,strong)NSString *latitude;//纬度
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *countryGet;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property (nonatomic) int getServerAddressNum;


@end

@implementation countryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=root_register;

      self.dataDic = [NSMutableDictionary dictionary];
    
//    UIImage *bgImage = IMAGE(@"bg.png");
//    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.view.backgroundColor=MainColor;

    [self.navigationController setNavigationBarHidden:NO];
     [self.navigationController.navigationBar setBarTintColor:MainColor];


    
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,50*HEIGHT_SIZE, 80*NOW_SIZE, 30*HEIGHT_SIZE)];
//    label.text=root_country;
//    label.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
//    label.textAlignment = NSTextAlignmentRight;
//    label.textColor=[UIColor whiteColor];
//    [self.view addSubview:label];
    
    
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60*NOW_SIZE,60*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE)];
    pwdBgImageView.image = IMAGE(@"圆角矩形空心.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:pwdBgImageView];
    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE,60*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE)];
//    _label.layer.borderWidth=1;
//    _label.layer.cornerRadius=5;
//    _label.layer.borderColor=[UIColor whiteColor].CGColor;
    _label.text =root_country_alet;
    _label.textColor = [UIColor lightTextColor];
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickadress)];
    [_label addGestureRecognizer:tap];
    
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,100*HEIGHT_SIZE, 80*NOW_SIZE, 30*HEIGHT_SIZE)];
//    label2.text=root_weiZhi;
//    label2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
//     label2.textAlignment = NSTextAlignmentRight;
//    label2.textColor=[UIColor whiteColor];
//    [self.view addSubview:label2];
    
    UIImageView *pwdBgImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(60*NOW_SIZE,120*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE)];
    pwdBgImageView1.image = IMAGE(@"圆角矩形空心.png");
    pwdBgImageView1.userInteractionEnabled = YES;
    [self.view addSubview:pwdBgImageView1];
    
  _label2=[[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE,120*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE)];
//    _label2.layer.borderWidth=1;
//    _label2.layer.cornerRadius=5;
//    _label2.layer.borderColor=[UIColor whiteColor].CGColor;
    _label2.text =root_weiZhi_tiShi;
    _label2.textColor = [UIColor lightTextColor];
    //textField.tintColor = [UIColor whiteColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_label2];
    _label2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fetchLocation)];
    [_label2 addGestureRecognizer:tap2];
    
   
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,190*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
       [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
  goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
        [self _getPickerData0];
}


- (void)_getPickerData0{
    _getServerAddressNum=0;
[self _getPickerData];
}

- (void)_getPickerData
{
    
    _getServerAddressNum++;
    
    NSString *serverInitAddress;
    if ([self.languageType isEqualToString:@"0"]) {
        serverInitAddress=HEAD_URL_Demo_CN;
    }else{
        serverInitAddress=HEAD_URL_Demo;
    }
    
    if (_getServerAddressNum==2) {
        if ([serverInitAddress isEqualToString:HEAD_URL_Demo_CN]) {
            serverInitAddress=HEAD_URL_Demo;
        }else if ([serverInitAddress isEqualToString:HEAD_URL_Demo]){
            serverInitAddress=HEAD_URL_Demo_CN;
        }
    }

    _provinceArray=[NSMutableArray array];
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:serverInitAddress paramars:@{@"admin":@"admin"} paramarsSite:@"/newCountryCityAPI.do?op=getCountryCity" sucessBlock:^(id content) {
           [self hideProgressView];
        NSLog(@"getCountryCity: %@", content);
        if (content) {
            NSArray *dataDic=[NSArray arrayWithArray:content];
            if (dataDic.count>0) {
                for (int i=0; i<dataDic.count; i++) {
                    NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"country"]];
                    [ _provinceArray addObject:DY];
                }
             
                [_provinceArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                    NSString *str1=(NSString *)obj1;
                    NSString *str2=(NSString *)obj2;
                    return [str1 compare:str2];
                }];
                
                [_provinceArray insertObject:@"A1_中国" atIndex:0];
            }else{
                if (_getServerAddressNum==1) {
                    [self _getPickerData];
                }else{
                       [self hideProgressView];
                    [self showToastViewWithTitle:root_Networking];
                }
            }
            
   
            
        }else{
        [self hideProgressView];
            if (_getServerAddressNum==1) {
                [self _getPickerData];
            }else{
                [self showToastViewWithTitle:root_Networking];
            }
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        if (_getServerAddressNum==1) {
            [self _getPickerData];
        }else{
            [self showToastViewWithTitle:root_Networking];
        }
    }];
    
}




-(void)fetchLocation{
    
    NSArray*nameArray=@[root_MAX_498,root_MAX_499,root_MAX_500];
    [ZJBLStoreShopTypeAlert showWithTitle:root_MAX_501 titles:nameArray selectIndex:^(NSInteger SelectIndexNum){
        if (SelectIndexNum==0) {
            [self autoGetLocation];
        }
        if (SelectIndexNum==1) {
            [self inputGetLocation];
        }
        if (SelectIndexNum==2) {
            
        }
        
    } selectValue:^(NSString* valueString){
     
    } showCloseButton:YES];
    
    


}


-(void)autoGetLocation{
    
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        _longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        _latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        _city=placemark.locality;
        _countryGet=placemark.country;
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        _label2.text =lableText;
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];
    
}


-(void)inputGetLocation{
    
    inputLocationView *log=[[inputLocationView alloc]init];
    log.locationArrayBlock=^(NSArray* locationArray){
               _city=locationArray[0];
        _longitude=locationArray[1];
        _latitude=locationArray[2];
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        _label2.text =lableText;
    };
    
    [self.navigationController pushViewController:log animated:YES];
    
}





- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

-(void)PresentGo{
    
 
    if (_country == nil || _country == NULL){
        [_dataDic setObject:@"" forKey:@"regCountry"];
    }else{
          [_dataDic setObject:_country forKey:@"regCountry"];
    }
    if (_city == nil || _city == NULL){
        [_dataDic setObject:@"" forKey:@"regCity"];
    }else{
     [_dataDic setObject:_city forKey:@"regCity"];
    }
    if (_longitude == nil || _longitude == NULL){
        [_dataDic setObject:@"" forKey:@"regLng"];
    }else{
        [_dataDic setObject:_longitude forKey:@"regLng"];
    }
    if (_latitude == nil || _latitude == NULL){
        [_dataDic setObject:@"" forKey:@"regLat"];
    }else{
        [_dataDic setObject:_latitude forKey:@"regLat"];
    }
    
    
    NSString *city=[self.dataDic objectForKey:@"regCountry"];
    if (city.length==0) {
        [self showToastViewWithTitle:root_country_kong];
        return;
    }
    
 registerViewController *reg=[[registerViewController alloc]initWithDataDict:_dataDic];
    [self. navigationController pushViewController:reg animated:YES];
}

-(void)Presentback{
    loginViewController *log=[[loginViewController alloc]init];
    
    [self presentViewController:log animated:YES completion:nil];
    
}

-(void)pickadress{
    
    if(_provinceArray.count>0){
    
        AnotherSearchViewController *another = [AnotherSearchViewController new];
        //返回选中搜索的结果
        [another didSelectedItem:^(NSString *item) {
           _label.text  = item;
            _country=item;
        }];
        another.title =root_xuanzhe_country;
        another.dataSource=_provinceArray;
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:root_country_huoQu];
        return;
    }
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
