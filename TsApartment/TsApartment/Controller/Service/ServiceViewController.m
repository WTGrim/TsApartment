//
//  ServiceViewController.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceViewController.h"
#import "WTCycleScrollView.h"
#import "HomeSectionHeader.h"
#import "ServiceInfoCell.h"
#import "ServiceOnlineCell.h"
#import "CommonBottomView.h"
#import "ServiceInfoListController.h"
#import "NetworkTool.h"
#import "publicAreaBookView.h"
#import "CircumViewController.h"
#import "ServiceCircumCell.h"

#define CYCLE_H SCREEN_WIDTH * (650 / 750.0)
#define HEADER_H 40
#define MARGIN 15
#define SECTION_0_H (SCREEN_WIDTH - 2 * MARGIN - 2 * 5) / 3.0 + 20
#define SECTION_1_H 260
#define SECTION_2_H 260

@interface ServiceViewController ()<UITableViewDelegate, UITableViewDataSource, CycleScrollViewDelegate>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//轮播
@property(nonatomic, strong)WTCycleScrollView *cycleScrollView;
//topView做下拉放大
@property(nonatomic, strong)UIView *topView;
//banner
@property(nonatomic, strong)NSArray *serviceBannerArr;
//menu
@property(nonatomic, strong)NSArray *menuArray;
//服务资讯列表
@property(nonatomic, strong)NSArray *serviceInfoList;
//周边商业列表
@property(nonatomic, strong)NSArray *circleCommerceList;
//公区预约
@property(nonatomic, strong)publicAreaBookView *bookView;
//页码
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    [self getData];
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

#pragma mark - initView
- (void)setupUI{
    [self commonConfig];
    [self initNav];
    [self initTableView];
    [self initTopView];

}

- (void)commonConfig{
    _pageIndex = 1;
}

- (void)getData{
    [self getServiceBanner];
    [self getServiceMenu];
    [self getServiceInfoList];
}

#pragma mark - 获取服务轮播图
- (void)getServiceBanner{
    [NetworkTool getServiceBannerWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self presentBanner:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 获取服务菜单
- (void)getServiceMenu{
    [NetworkTool getServiceMenuWithSucceedBlock:^(NSDictionary * _Nullable result) {
        [self presentServiceMenu:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 服务资讯列表
- (void)getServiceInfoList{
    [NetworkTool getServiceInfoListWithPageIndex:_pageIndex succeedBlock:^(NSDictionary * _Nullable result) {
        [self presentServiceInfoList:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentServiceInfoList:(NSArray *)array{
    _serviceInfoList = [NSArray arrayWithArray:array];
    [_tableView reloadData];
}

- (void)presentServiceMenu:(NSArray *)array{
    
    _menuArray= [NSArray arrayWithArray:array];
    [self.bookView setBookViewWithDict:array.lastObject];
    [_tableView reloadData];
}

- (void)presentBanner:(NSArray *)array{
    if (array.count == 0) {
        
    }
    _serviceBannerArr = [NSArray arrayWithArray:array];
    __block NSMutableArray *imgs = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imgs addObject:[obj objectForKey:kImgUrl]];
    }];
    self.cycleScrollView.imageUrlsArray = imgs;
}

- (void)initNav{
    self.navigationItem.title = nil;
}

#pragma mark - 初始化tableView
- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - SAFE_BOTTOM_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(- SAFE_NAV_HEIGHT + CYCLE_H, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[ServiceInfoCell class] forCellReuseIdentifier:NSStringFromClass([ServiceInfoCell class])];
    [_tableView registerClass:[ServiceOnlineCell class] forCellReuseIdentifier:NSStringFromClass([ServiceOnlineCell class])];
    [_tableView registerClass:[ServiceCircumCell class] forCellReuseIdentifier:NSStringFromClass([ServiceCircumCell class])];

    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [CommonBottomView shareInstance];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
}

#pragma mark - 做下拉放大
- (void)initTopView{
    
    //    _tableView.tableHeaderView = self.cycleScrollView;
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, -CYCLE_H, SCREEN_WIDTH, CYCLE_H)];
    _topView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview:_topView];
    [_topView addSubview:self.cycleScrollView];
}

#pragma mark - 查看更多
- (void)checkMore:(NSInteger)section{
    switch (section) {
        case 1://服务资讯
        {
            ServiceInfoListController *listVc = [[ServiceInfoListController alloc]init];
            listVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:listVc animated:true];
        }
            break;
        case 2://周边商业
        {
            CircumViewController *circumVc = [[CircumViewController alloc]init];
            circumVc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:circumVc animated:true];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            ServiceOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceOnlineCell class]) forIndexPath:indexPath];
            if (_menuArray.count != 0) {
                [cell setCellWithArray:_menuArray];
            }
            return cell;
        }
            break;
        case 1:
        {
            ServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceInfoCell class]) forIndexPath:indexPath];
            if (_serviceInfoList.count != 0) {
                [cell setCellWithArray:_serviceInfoList cellType:ServiceInfoCellType_ServiceInfo];
            }
            return cell;
            
        }
            break;
            
        case 2:
        {
            ServiceCircumCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceCircumCell class]) forIndexPath:indexPath];
            
            if (_circleCommerceList.count != 0) {
                [cell setCellWithArray:_circleCommerceList];
            }
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HomeSectionHeader *header = [[HomeSectionHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    NSArray *titles = @[@"在线服务", @"服务资讯", @"周边商业"];
    header.title = titles[section];
    if (section == 0) {
        header.hiddenCheckMore = true;
    }
    WEAKSELF;
    header.checkMore = ^{
        [weakSelf checkMore:section];
    };
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
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
    if (section == 0) {
        return 100;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return HEADER_H + 20;
    }
    return HEADER_H;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.bookView;
    }
    return nil;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top + SAFE_NAV_HEIGHT;
        NSLog(@"%.2f", offsetY);
        if (offsetY <= 0 ) {
            _topView.wt_height = CYCLE_H - offsetY;
            _topView.wt_y = -CYCLE_H + offsetY;
            self.cycleScrollView.wt_height = CYCLE_H - offsetY;
        }
    }
}

#pragma mark -lazy
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

- (publicAreaBookView *)bookView{
    if (!_bookView) {
        _bookView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([publicAreaBookView class]) owner:nil options:nil].firstObject;
    }
    return _bookView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
