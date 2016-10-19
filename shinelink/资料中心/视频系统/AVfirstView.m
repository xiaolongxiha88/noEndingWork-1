//
//  AVfirstView.m
//  ShinePhone
//
//  Created by sky on 16/9/2.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AVfirstView.h"
#import "AVViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "AnotherSearchViewController.h"
#import "UIImageView+WebCache.h"



#define Width [UIScreen mainScreen].bounds.size.width

@interface AVfirstView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UILabel *indicateLabel;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSMutableArray *searchArray;

@property(nonatomic,strong)NSMutableArray *AvName;
@property(nonatomic,strong)NSMutableArray *AvOutline;
@property(nonatomic,strong)NSMutableArray *AvUrl;
@property(nonatomic,strong)NSMutableArray *AvPicUrl;

@property(nonatomic,strong)NSMutableArray *AvName2;
@property(nonatomic,strong)NSMutableArray *AvOutline2;
@property(nonatomic,strong)NSMutableArray *AvUrl2;
@property(nonatomic,strong)NSMutableArray *AvPicUrl2;

@end

@implementation AVfirstView
{
    float cellWidth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self getAvNet];
    
    //[self initData];
 
   // [self setupUI];
    
}


-(void)getAvNet{

    _AvName=[NSMutableArray array];
    _AvOutline=[NSMutableArray array];
    _AvUrl=[NSMutableArray array];
    _AvPicUrl=[NSMutableArray array];
    _AvName2=[NSMutableArray array];
    _AvOutline2=[NSMutableArray array];
    _AvUrl2=[NSMutableArray array];
    _AvPicUrl2=[NSMutableArray array];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue ;
    

    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    NSDictionary *dicGo=[NSDictionary new];
    dicGo=@{@"language":_languageValue,@"dirId":_dirID} ;
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:@"/newVideoAPI.do?op=getVideoInfoList" sucessBlock:^(id content) {
        
        [self hideProgressView];
        NSLog(@"getVideoInfoList: %@", content);
   NSString *resultValue=[NSString stringWithFormat:@"%@",content[@"result"]];
        
        if ([resultValue isEqualToString:@"1"]) {
        
            NSArray *objAll=[NSArray arrayWithArray:content[@"obj"]];
            if (objAll.count>0) {
                for (int i=0; i<objAll.count; i++) {
                    
                    [_AvName addObject:objAll[i][@"videoTitle"]];
                    [_AvUrl addObject:objAll[i][@"videoPicurl"]];
                    
                    
                    NSString *picUrl=[NSString stringWithFormat:@"%@/%@",Head_Url_more,objAll[i][@"videoImgurl"]];
                    
                    [_AvPicUrl addObject:picUrl];
                    [_AvOutline addObject:objAll[i][@"videoOutline"]];
                    
                    
                    if (i<3) {
                        [_AvName2 addObject:objAll[i][@"videoTitle"]];
                        [_AvUrl2 addObject:objAll[i][@"videoPicurl"]];
                        [_AvPicUrl2 addObject:picUrl];
                        [_AvOutline2 addObject:objAll[i][@"videoOutline"]];
                    }
                    
                    
                    
                    if (_AvPicUrl.count==objAll.count) {
                        [self initData];
                        [self saveData];
                    }
                    
                }
                
            }
        
        }
        
        
    } failure:^(NSError *error) {
           [self hideProgressView];
          [self showToastViewWithTitle:root_Networking];
    }];


}


-(void)saveData{

 NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *AvPicUrl3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvPicUrl"]];
     NSMutableArray *AvUrl3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvUrl"]];
         NSMutableArray *AvName3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvName"]];
         NSMutableArray *AvOutline3 =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"AvOutline"]];
    
    for (int i=0; i<_AvName.count; i++) {
        if (![AvName3 containsObject:_AvName[i]]) {
            [ AvPicUrl3 addObject:_AvPicUrl[i]];
              [ AvUrl3 addObject:_AvUrl[i]];
             [ AvName3 addObject:_AvName[i]];
               [ AvOutline3 addObject:_AvOutline[i]];
        }
        
    }
    
    [userDefaultes setObject:AvPicUrl3 forKey:@"AvPicUrl"];
       [userDefaultes setObject:AvUrl3 forKey:@"AvUrl"];
       [userDefaultes setObject:AvName3 forKey:@"AvName"];
       [userDefaultes setObject:AvOutline3 forKey:@"AvOutline"];
    
}


-(void)initData{
    cellWidth=SCREEN_Width/2-6*NOW_SIZE;
    
    _searchArray = [NSMutableArray arrayWithArray:_AvName];
    
    _collectionNameArray=[NSMutableArray arrayWithArray:_AvName];
    
    
     [self setupUI];
    

    
    
    
}

- (void)setupUI {
    
//    _label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,0*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
//        _label.layer.borderWidth=1;
//        _label.layer.cornerRadius=15*HEIGHT_SIZE;
//        _label.layer.borderColor=MainColor.CGColor;
//    _label.text =root_sousuo;
//    _label.textColor = MainColor;
//    //textField.tintColor = [UIColor whiteColor];
//    _label.textAlignment = NSTextAlignmentCenter;
//    _label.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    [self.view addSubview:_label];
//    _label.userInteractionEnabled=YES;
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAV)];
//    [_label addGestureRecognizer:tap];
    
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0*HEIGHT_SIZE, Width, (Width - 84) * 9 / 16 + 24*HEIGHT_SIZE)];
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 1;
    _pageFlowView.minimumPageScale = 0.9;
    _pageFlowView.autoTime=5;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24*HEIGHT_SIZE - 8*HEIGHT_SIZE, Width, 8*HEIGHT_SIZE)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
      [_pageFlowView startTimer];
    [self.view addSubview:_pageFlowView];
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
    
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0,_indicateLabel.frame.origin.y+_indicateLabel.frame.size.height+5*HEIGHT_SIZE,SCREEN_Width,4*HEIGHT_SIZE)];
    line1.backgroundColor=COLOR(194, 195, 204, 0.75);
    [self.view addSubview:line1];
    
    
    float line1Y=CGRectGetMaxY(line1.frame);
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView * collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, line1Y, SCREEN_Width, 1*(SCREEN_Height-line1Y-90*HEIGHT_SIZE)) collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView setBackgroundColor:[UIColor colorWithRed:179/255.0f green:179/255.0f blue:179/255.0f alpha:1]];
    
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
      [self.view addSubview:collectionView];
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 84, (Width - 84) * 9 / 16);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.AvPicUrl.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
     NSURL* imagePath = [NSURL URLWithString:_AvPicUrl[index]];
    
     [bannerView.mainImageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"pic_service.png"]];
    
    //  [bannerView.mainImageView sd_setImageWithURL:_AvPicUrl[index]];
   // bannerView.mainImageView.image = self.imageArray[index];
    
    
    bannerView.allCoverButton.tag = index;
    [bannerView.allCoverButton addTarget:self action:@selector(didSelectBannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return bannerView;
}


-(void)searchAV{

    AnotherSearchViewController *another = [AnotherSearchViewController new];
    //返回选中搜索的结果
    [another didSelectedItem:^(NSString *item) {
        _label.text  = item;
        
    }];
    another.title =root_xuanzhe_country;
    another.dataSource=_searchArray;
    [self.navigationController pushViewController:another animated:YES];
    

}



#pragma mark --点击轮播图
- (void)didSelectBannerButtonClick:(UIButton *) sender {
    
    NSInteger index = sender.tag;
    
    NSLog(@"点击了第%ld张图",(long)index + 1);
    
    // self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)index + 1];
    
    
    AVViewController *goAV=[[AVViewController alloc]init];
    goAV.AvUrl=_AvUrl[index];
    goAV.AvPicUrl=_AvPicUrl[index];
    goAV.contentLabelTextValue=_AvOutline[index];
    goAV.title=_AvName[index];
    goAV.tableCellName=[NSMutableArray arrayWithArray:_AvName2];
    goAV.tableCellPic=[NSMutableArray arrayWithArray:_AvPicUrl2];
    goAV.tableCellOutline=[NSMutableArray arrayWithArray:_AvOutline2];
    goAV.tableCellUrl=[NSMutableArray arrayWithArray:_AvUrl2];
    
    [self.navigationController pushViewController:goAV animated:YES];
    
    
}


- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
     self.indicateLabel.text = _AvName[pageNumber];
    
   // NSLog(@"滚动到了第%ld页",(long)pageNumber);
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UILabel *)indicateLabel {
    
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.origin.y+_pageFlowView.frame.size.height, Width, 16)];
        _indicateLabel.textColor = MainColor;
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = _AvName[0];
    }
    
    return _indicateLabel;
}



#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _AvName.count/2;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    float cellx=3*NOW_SIZE;
    
    static NSString * CellIdentifier = @"UICollectionViewCell";
 
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    
    cell.backgroundColor =  [UIColor whiteColor];
    
    int i=indexPath.row+2*indexPath.section;
    
     UIImageView  * AVimageView=[[UIImageView alloc] initWithFrame:CGRectMake(cellx, 0, cellWidth,cellWidth*9/16)];

    NSURL* imagePath = [NSURL URLWithString:_AvPicUrl[i]];
    
    [AVimageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"pic_service.png"]];
    
    [cell.contentView addSubview: AVimageView];
    
    float AVimageViewH=CGRectGetMaxY(AVimageView.frame);
    
    
     UILabel *AVname = [[UILabel alloc] init];
    AVname.textColor = MainColor;
    AVname.font=[UIFont systemFontOfSize:13 *HEIGHT_SIZE];
    AVname.numberOfLines=0;
    AVname.text=_AvName[i];
    AVname.textAlignment=NSTextAlignmentLeft;
    CGRect fcRect = [_AvName[i] boundingRectWithSize:CGSizeMake(cellWidth, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *HEIGHT_SIZE]} context:nil];
    AVname.frame=CGRectMake(cellx, AVimageViewH+3*HEIGHT_SIZE,  cellWidth, fcRect.size.height);
      [cell.contentView addSubview:AVname];
    
    
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CGRect fcRect = [_collectionNameArray[indexPath.row] boundingRectWithSize:CGSizeMake(cellWidth, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *HEIGHT_SIZE]} context:nil];
    
    return CGSizeMake((SCREEN_Width)/2, cellWidth*9/16+45*HEIGHT_SIZE);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 3*NOW_SIZE, 0 );
}





#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //    cell.backgroundColor = [UIColor greenColor];
    
        int i=indexPath.row+2*indexPath.section;
    
    AVViewController *goAV=[[AVViewController alloc]init];
    goAV.AvUrl=_AvUrl[i];
    goAV.AvPicUrl=_AvPicUrl[i];
    goAV.contentLabelTextValue=_AvOutline[i];
    goAV.title=_AvName[i];
    goAV.tableCellName=[NSMutableArray arrayWithArray:_AvName2];
    goAV.tableCellPic=[NSMutableArray arrayWithArray:_AvPicUrl2];
    goAV.tableCellOutline=[NSMutableArray arrayWithArray:_AvOutline2];
    goAV.tableCellUrl=[NSMutableArray arrayWithArray:_AvUrl2];
    
    [self.navigationController pushViewController:goAV animated:YES];
    
    
    
    
    
    NSLog(@"item======%ld",(long)indexPath.item);
    NSLog(@"row=======%ld",(long)indexPath.row);
    NSLog(@"section===%ld",(long)indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




-(void)goAV{
    AVViewController *go=[[AVViewController alloc]init];
    [self.navigationController pushViewController:go animated:YES];
    
}



-(void)viewDidDisappear:(BOOL)animated{
    
      [_pageFlowView stopTimer];
    
}


-(void)viewWillAppear:(BOOL)animated{

     [_pageFlowView startTimer];
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
