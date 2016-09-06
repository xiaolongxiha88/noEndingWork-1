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

#define Width [UIScreen mainScreen].bounds.size.width

@interface AVfirstView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UILabel *indicateLabel;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSMutableArray *searchArray;


@end

@implementation AVfirstView
{
    float cellWidth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
 
    [self setupUI];
    
}


- (void)setupUI {
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,0*HEIGHT_SIZE, 300*NOW_SIZE, 30*HEIGHT_SIZE)];
        _label.layer.borderWidth=1;
        _label.layer.cornerRadius=15*HEIGHT_SIZE;
        _label.layer.borderColor=MainColor.CGColor;
    _label.text =@"搜索";
    _label.textColor = MainColor;
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAV)];
    [_label addGestureRecognizer:tap];
    
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 30*HEIGHT_SIZE, Width, (Width - 84) * 9 / 16 + 24)];
    _pageFlowView.backgroundColor = [UIColor whiteColor];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.8;
    _pageFlowView.minimumPageScale = 0.92;
    _pageFlowView.autoTime=5;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 24 - 8, Width, 8)];
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
    
    UICollectionView * collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, line1Y, SCREEN_Width, SCREEN_Height-line1Y) collectionViewLayout:flowLayout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView setBackgroundColor:[UIColor colorWithRed:179/255.0f green:179/255.0f blue:179/255.0f alpha:1]];
    
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
      [self.view addSubview:collectionView];
    
}



-(void)initData{
      cellWidth=SCREEN_Width/2-6*NOW_SIZE;
    
    _searchArray = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
                   @"瓦洛兰 Valoran",
                   @"德玛西亚 Demacia",
                   @"诺克萨斯 Noxus",
                   @"艾欧尼亚 Ionia",
                   @"皮尔特沃夫 Piltover",
                   @"弗雷尔卓德 Freijord",
                   @"班德尔城 Bandle City",
                   @"战争学院 The Institute of War",
                   @"祖安 Zaun",
                   @"卡拉曼达 Kalamanda",
                   @"蓝焰岛 Blue Flame Island",
                   @"哀嚎沼泽 Howling Marsh",
                   @"艾卡西亚 Icathia",
                   @"铁脊山脉 Ironspike Mountains",
                   @"库莽古丛林 Kumungu",
                   @"洛克法 Lokfar"];

    _collectionNameArray=[NSMutableArray arrayWithObjects:@"我是大大大蝴蝶花", @"我是大大大大大蝴蝶花",@"我是大大大大大大大花",@"我是大大大蝴蝶花",@"我是大大大蝴蝶花",nil];
    
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:@"pic_service.png"];
        [self.imageArray addObject:image];
    }

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
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
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
    
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)index + 1];
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"滚动到了第%ld页",(long)pageNumber);
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
        _indicateLabel.text = @"这是一个强大的视频系统";
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
    return _collectionNameArray.count;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    float cellx=3*NOW_SIZE;
    
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor =  [UIColor whiteColor];
    
     UIImageView  * AVimageView=[[UIImageView alloc] initWithFrame:CGRectMake(cellx, 0, cellWidth,cellWidth*9/16)];
    [ AVimageView setImage:[UIImage imageNamed:@"pic_service.png"]];
    [cell.contentView addSubview: AVimageView];
    
    float AVimageViewH=CGRectGetMaxY(AVimageView.frame);
    
    
     UILabel *AVname = [[UILabel alloc] init];
    AVname.textColor = MainColor;
    AVname.font=[UIFont systemFontOfSize:13 *HEIGHT_SIZE];
    AVname.numberOfLines=0;
    AVname.text=_collectionNameArray[indexPath.row];
    AVname.textAlignment=NSTextAlignmentLeft;
    CGRect fcRect = [_collectionNameArray[indexPath.row] boundingRectWithSize:CGSizeMake(cellWidth, 2000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *HEIGHT_SIZE]} context:nil];
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


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
          UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
      
        
    }
    
return reusableview;
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    //    cell.backgroundColor = [UIColor greenColor];
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
