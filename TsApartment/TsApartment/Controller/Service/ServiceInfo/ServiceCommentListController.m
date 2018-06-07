//
//  ServiceCommentListController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceCommentListController.h"
#import "NetworkTool.h"
#import "CommentBottomView.h"
#import "CommentModel.h"
#import "CommentCellModel.h"

#define BOTTOM_H 50

@interface ServiceCommentListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, assign)NSInteger pageIndex;
//评论框
@property(nonatomic, strong)CommentBottomView *bottomView;
@property (nonatomic,strong)NSIndexPath *commentIndexpath;
@property (nonatomic,strong)NSIndexPath *replyIndexpath;
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
    [self initBottomView];
}

- (void)initBottomView{
    _bottomView = [[CommentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - BOTTOM_H - SAFE_NAV_HEIGHT, SCREEN_WIDTH, BOTTOM_H)];
    WEAKSELF;
    _bottomView.publicCallBack = ^(NSString *comment) {
        [weakSelf commentSend:comment parent_id:0];
    };
    [self.view addSubview:_bottomView];
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 发布评论
- (void)commentSend:(NSString *)commentString parent_id:(NSInteger)parent_id{
    
    CommentCellModel *model = self.dataArray[self.commentIndexpath.row];
    
    CommentModel *newComModel = [[CommentModel alloc] init];
    //    newComModel.userName = @"Sky";
    //    if(self.replyIndexpath)
    //    {
    //        CommentModel *comModel = model.commentArray[self.replyIndexpath.row];
    //        newComModel.replyUserName = comModel.userName;
    //    }
    //    newComModel.content = commentString;
    //
    //    NSMutableArray *mutableArray = model.commentArray.mutableCopy;
    //    [mutableArray addObject:newComModel];
    //    model.commentArray = mutableArray.copy;
    //
    //    [self.tableView reloadRowsAtIndexPaths:@[self.commentIndexpath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSInteger parentId = 0;
    self.replyIndexpath = nil;
    [self sendComment:commentString parentId:parent_id];
}

- (void)sendComment:(NSString *)commmentString parentId:(NSInteger)parentId{
    WEAKSELF;
    [NetworkTool serviceInfoComment_submitWithId:_Id content:commmentString ip_address:@"" parent_id:parentId succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf commentSucceed:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

#pragma mark - 评论成功
- (void)commentSucceed:(NSArray *)array{
    
}


- (void)commonConfig{
    _pageIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
