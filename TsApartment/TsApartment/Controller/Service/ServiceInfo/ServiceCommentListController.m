//
//  ServiceCommentListController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceCommentListController.h"
#import "NetworkTool.h"

@interface ServiceCommentListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation ServiceCommentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self getCommentsData];

}

- (void)getCommentsData{
    WEAKSELF;
    [NetworkTool getServiceInfo_commentListWithId:_Id pageIndex:_pageIndex succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf presentCommentsData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)presentCommentsData:(NSArray *)array{
    
}

- (void)setupUI{
    
    [self commonConfig];
    [self initTableView];
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)commonConfig{
    _pageIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
