//
//  HomeViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeLocationView.h"
#import "LocationChooseController.h"
#import "MessageView.h"
#import "QRCodeScannerViewController.h"
#import "MessageViewController.h"
#import "WTCycleScrollView.h"
#import "HomeSectionHeader.h"
#import "DistributedCell.h"
#import "ActivityTableViewCell.h"
#import "CentTableViewCell.h"
#import "MapViewController.h"
#import "CentralizedViewController.h"
#import "DistributedViewController.h"
#import "CommonBottomView.h"

#define CYCLE_H SCREEN_WIDTH * (650 / 750.0)
#define HEADER_H 40
#define SECTION_0_H 230
#define SECTION_1_H 260
#define SECTION_2_H 100
#define MAP_BTN_W 80

@interface HomeViewController ()<CycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

//城市选择控件
@property(nonatomic, strong)HomeLocationView *locationView;
//消息选择控件
@property(nonatomic, strong)MessageView *messageView;
//tableView
@property(nonatomic, strong)UITableView *tableView;
//数据源
@property(nonatomic, strong)NSMutableArray *dataArray;
//轮播
@property(nonatomic, strong)WTCycleScrollView *cycleScrollView;
//地图按钮
@property(nonatomic, strong)UIButton *mapBtn;
//topView做下拉放大
@property(nonatomic, strong)UIView *topView;
//搜索的view
@property(nonatomic, strong)UIView *searchView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = true;
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = false;
}

#pragma mark - 初始化视图
- (void)setupUI{

    [self initNavBar];
    [self initTableView];
    [self initTopView];
    [self initMapBtn];
    [self initSearchView];
}

#pragma mark - 设置导航栏
- (void)initNavBar{

    self.title = @"";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.locationView];
    UIBarButtonItem *message = [[UIBarButtonItem alloc]initWithCustomView:self.messageView];
    UIBarButtonItem *scan = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"scan"] style:UIBarButtonItemStylePlain target:self action:@selector(scanClick)];
    self.navigationItem.rightBarButtonItems = @[message, scan];
}

#pragma mark - 做下拉放大
- (void)initTopView{
    
//    _tableView.tableHeaderView = self.cycleScrollView;

    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, -CYCLE_H, SCREEN_WIDTH, CYCLE_H)];
    _topView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview:_topView];
    
    
    self.cycleScrollView.imageUrlsArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511040590&di=ed2001ef02975c71c987d2ecba5bcbae&imgtype=0&src=http%3A%2F%2Fpic.shejiben.com%2Fattch%2Fday_150328%2F20150328_acb1b271035fc5125be59QzMrWqWJAGh.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511067406&di=acc9bc0006a2de06c092f3e22569fbd2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F31%2F93%2F25S58PICVyj_1024.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511096581&di=e2da1171e16a06f39130c556dcddfc07&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dpixel_huitu%252C0%252C0%252C294%252C40%2Fsign%3D082c3ff1114c510fbac9ea5a09214041%2F96dda144ad3459823ddf04ab07f431adcbef84b6.jpg"];
    [_topView addSubview:self.cycleScrollView];
}

- (void)initMapBtn{
    [self.view addSubview:self.mapBtn];
}

#pragma mark - 悬浮搜索（待定）
- (void)initSearchView{
    
}

#pragma mark - 初始化tableView
- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - SAFE_BOTTOM_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(- SAFE_NAV_HEIGHT + CYCLE_H, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[DistributedCell class] forCellReuseIdentifier:NSStringFromClass([DistributedCell class])];
    [_tableView registerClass:[CentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CentTableViewCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ActivityTableViewCell class])];
    _tableView.tableFooterView = [CommonBottomView shareInstance];
    
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:case 1:
            return 1;
            break;
            case 2:
            return 3;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            DistributedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DistributedCell class]) forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            CentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CentTableViewCell class]) forIndexPath:indexPath];
            return cell;
        }
            break;
        case 2:
        {
            ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ActivityTableViewCell class]) forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HomeSectionHeader *header = [[HomeSectionHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    NSArray *titles = @[@"分散式公寓", @"集中式公寓", @"社区活动"];
    header.title = titles[section];
    WEAKSELF;
    header.checkMore = ^{
        [weakSelf checkMore:section];
    };
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return SECTION_0_H;
            break;
        case 1:
            return SECTION_1_H;
            break;
        case 2:
            return SECTION_2_H;
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return HEADER_H + 20;
    }
    return HEADER_H;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - 查看更多
- (void)checkMore:(NSInteger)section{
    
    switch (section) {
        case 0://分散式
        {
            DistributedViewController *distriVc = [[DistributedViewController alloc]init];
            distriVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:distriVc animated:true];
        }
            break;
        case 1://集中式
        {
            CentralizedViewController *centraVc = [[CentralizedViewController alloc]init];
            centraVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:centraVc animated:true];
        }
            break;
        case 2://社区活动
        {
            
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top + SAFE_NAV_HEIGHT;
        NSLog(@"%.2f", offsetY);
        if (offsetY <= 0 ) {
            self.mapBtn.wt_y = - offsetY + CYCLE_H - MAP_BTN_W * 0.5;
            _topView.wt_height = CYCLE_H - offsetY;
            _topView.wt_y = -CYCLE_H + offsetY;
            self.cycleScrollView.wt_height = CYCLE_H - offsetY;
        }
    }
}

#pragma mark - 点击扫描
- (void)scanClick{
    __weak typeof(self)weakSelf = self;
    QRCodeScannerViewController *vc = [[QRCodeScannerViewController alloc]initWithCardName:nil centerImage:nil completed:^(NSString *result) {
        //扫描结果
        
    }];
    [self showDetailViewController:vc sender:nil];
}

#pragma mark - 点击地图
- (void)mapBtnClick{
    
    MapViewController *mapVc = [[MapViewController alloc]init];
    mapVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:mapVc animated:true];
}

#pragma mark - lazy
//地址选择
- (HomeLocationView *)locationView{
    if (!_locationView) {
        WEAKSELF;
        _locationView = [[HomeLocationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3.0, 40) onClick:^{
            LocationChooseController *locationVc = [[LocationChooseController alloc]init];
            [weakSelf presentViewController:locationVc animated:true completion:nil];
        }];
    }
    return _locationView;
}

//消息
- (MessageView *)messageView{
    if (!_messageView) {
        WEAKSELF;
        _messageView = [[MessageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40) onClick:^{
            MessageViewController *messageVc = [[MessageViewController alloc]init];
            messageVc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController  pushViewController:messageVc animated:true];
        }];
    }
    return _messageView;
}

- (WTCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [WTCycleScrollView netCycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CYCLE_H) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.autoScroll = true;
        _cycleScrollView.loop = true;
        _cycleScrollView.showPageControl = true;
        _cycleScrollView.timeInterVal = 3;
        _cycleScrollView.contentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlAliment = PageControlAlimentCenter;
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    }
    return _cycleScrollView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UIButton *)mapBtn{
    if (!_mapBtn) {
        _mapBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - MAP_BTN_W - 20, CYCLE_H - MAP_BTN_W * 0.5, MAP_BTN_W, MAP_BTN_W)];
        [_mapBtn setImage:[UIImage imageNamed:@"home_map"] forState:UIControlStateNormal];
        _mapBtn.layer.cornerRadius = MAP_BTN_W * 0.5;
        _mapBtn.layer.masksToBounds = true;
        _mapBtn.layer.shadowOffset = CGSizeMake(2, 3);
        _mapBtn.layer.shadowOpacity = 0.8;
        [_mapBtn addTarget:self action:@selector(mapBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _mapBtn.layer.shadowColor = RGBA(0, 0, 0, 0.5).CGColor;
    }
    return _mapBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
