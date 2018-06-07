//
//  CircumPageViewController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumPageViewController.h"
#import "CircumListTableViewCell.h"
#import "CircumCommonHeader.h"

@interface CircumPageViewController ()<UITableViewDelegate, UITableViewDataSource>

//tableView
@property(nonatomic, strong)UITableView *tableView;
//data
@property(nonatomic, strong)NSMutableArray *dataArray;
//page
@property(nonatomic, assign)NSInteger pageIndex;

@property(nonatomic, strong)CircumCommonHeader *header;
@property(nonatomic, strong)NSArray *titles;
//header高度
@property(nonatomic, assign)CGFloat headerHeight;
//
@property(nonatomic, assign)BOOL isCorrectHeader;
@end

@implementation CircumPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

- (void)setupUI{
    
    _pageIndex = 1;
    _headerHeight = 100;
    _isCorrectHeader = false;
    [self initTableView];
}

#pragma mark - 获取数据
- (void)getData{
    
    _titles = @[@"全部", @"维修", @"保洁", @"洗车", @"安农"];
    [self.tableView reloadData];
}

- (void)presentData:(NSArray *)array{
    [_tableView.mj_footer endRefreshing];
    if (array.count < COMMON_PAGE_SIZE) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.dataArray addObjectsFromArray:array];
    [_tableView reloadData];
    if (array.count == 0 && _pageIndex == 1) {
        _tableView.mj_footer.hidden = true;
    }
}

#pragma mark - tableView
- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT - 40) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 160;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircumListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CircumListTableViewCell class])];
    [self.view addSubview:_tableView];
    WEAKSELF;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [self getData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CircumListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CircumListTableViewCell class]) forIndexPath:indexPath];
    if (self.dataArray.count != 0) {
        [cell setCellWithDict:self.dataArray[indexPath.row] indexPath:indexPath];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WEAKSELF;
    _header = [[CircumCommonHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) titles:_titles heightCallBack:^(CGFloat height) {
        weakSelf.headerHeight = height;
        if (!weakSelf.isCorrectHeader) {
            weakSelf.isCorrectHeader = true;
            [weakSelf.tableView reloadData];
        }
    }];
    return _header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - lazy
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
