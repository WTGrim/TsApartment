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

#define CYCLE_H SCREEN_WIDTH * (650 / 750.0)
#define HEADER_H 40
#define MARGIN 15
#define SECTION_0_H (SCREEN_WIDTH - 2 * MARGIN - 2 * 5) / 3.0 + 20
#define SECTION_1_H 260
#define SECTION_2_H 260

@interface ServiceViewController ()<UITableViewDelegate, UITableViewDataSource, CycleScrollViewDelegate>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//数据源
@property(nonatomic, strong)NSMutableArray *dataArray;
//轮播
@property(nonatomic, strong)WTCycleScrollView *cycleScrollView;
//topView做下拉放大
@property(nonatomic, strong)UIView *topView;

@end

@implementation ServiceViewController

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

#pragma mark - initView
- (void)setupUI{
    [self initNav];
    [self initTableView];
    [self initTopView];

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
    
    self.cycleScrollView.imageUrlsArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511040590&di=ed2001ef02975c71c987d2ecba5bcbae&imgtype=0&src=http%3A%2F%2Fpic.shejiben.com%2Fattch%2Fday_150328%2F20150328_acb1b271035fc5125be59QzMrWqWJAGh.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511067406&di=acc9bc0006a2de06c092f3e22569fbd2&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F14%2F31%2F93%2F25S58PICVyj_1024.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527511096581&di=e2da1171e16a06f39130c556dcddfc07&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dpixel_huitu%252C0%252C0%252C294%252C40%2Fsign%3D082c3ff1114c510fbac9ea5a09214041%2F96dda144ad3459823ddf04ab07f431adcbef84b6.jpg"];
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
            return cell;
        }
            break;
        case 1:case 2:
        {
            ServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ServiceInfoCell class]) forIndexPath:indexPath];
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

- (NSMutableArray *)dataArray{
    if (_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end