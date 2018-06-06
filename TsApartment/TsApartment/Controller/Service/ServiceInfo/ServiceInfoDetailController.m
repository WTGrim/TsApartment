//
//  ServiceInfoDetailController.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoDetailController.h"
#import "ServiceInfoDetailHeader.h"
#import "NetworkTool.h"
#import "CommentBottomView.h"
#import "DataSourceManager.h"
#import "CommonCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "CommentModel.h"
#import "CommentCellModel.h"

#define BOTTOM_H 50
@interface ServiceInfoDetailController ()<UITableViewDelegate, UITableViewDataSource, CommonCommentCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)ServiceInfoDetailHeader *header;
@property(nonatomic, assign)NSInteger pageIndex;
//评论框
@property(nonatomic, strong)CommentBottomView *bottomView;

@property (nonatomic,strong)NSIndexPath *commentIndexpath;
@property (nonatomic,strong)NSIndexPath *replyIndexpath;
@property (nonatomic,assign)CGFloat totalKeybordHeight;


@end

@implementation ServiceInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getData];
}

#pragma mark - initView
- (void)setupUI{
    
    self.title = @"资讯详情";
    _pageIndex = 1;
    [self initTableView];
    [self initBottomView];
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_NAV_HEIGHT -BOTTOM_H) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initBottomView{
    _bottomView = [[CommentBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - BOTTOM_H - SAFE_NAV_HEIGHT, SCREEN_WIDTH, BOTTOM_H)];
    WEAKSELF;
    _bottomView.publicCallBack = ^(NSString *comment) {
        [weakSelf commentSend:comment parent_id:0];
    };
    [self.view addSubview:_bottomView];
}

#pragma mark - 获取数据
- (void)getData{
    
    [self getServiceDetailData];
    [self getCommentsData];
}

- (void)getServiceDetailData{
    WEAKSELF;
    [NetworkTool getServiceInfoDetailWithId:_Id succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf persentData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)getCommentsData{
    WEAKSELF;
    [NetworkTool getServiceInfo_commentListWithId:_Id pageIndex:_pageIndex succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf presentCommentsData:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)persentData:(NSDictionary *)dict{
    WEAKSELF;
    [self.header setHeaderWithDict:dict heightCallBack:^(CGFloat height) {
        weakSelf.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [weakSelf.tableView reloadData];
    }];
}

- (void)presentCommentsData:(NSArray *)array{
    
    if (array.count == 0) {
        return;
    }
    CommentCellModel *model = [[CommentCellModel alloc] init];
    
    [self.dataArray addObjectsFromArray:array];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF;
    CGFloat h = [CommonCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CommonCommentCell *cell = (CommonCommentCell *)sourceCell;
        [weakSelf  configureCell:cell atIndexPath:indexPath];
    }];
    return h;
}

- (void)configureCell:(CommonCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [cell setCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommonCommentCell class])];
    if (!cell) {
        cell = [[CommonCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommonCommentCell class])];
        cell.delegate = self;
    }
    cell.backgroundColor = [UIColor whiteColor];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark -- 点击全文、收起
-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;{
    CommentCellModel *model = self.dataArray[indexPath.row];
    model.isExpand = !model.isExpand;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -- 点击评论按钮
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark -- 点击赞
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath{
    CommentCellModel *model = self.dataArray[indexPath.row];
//    NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
//    model.isLiked ==YES ? [likeArray removeObject:@"Sky"]:[likeArray addObject:@"Sky"];
//
//    model.likeNameArray = [likeArray copy];
//    model.isLiked = !model.isLiked;
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self sendLike];
}

#pragma mark - 点赞网络请求
- (void)sendLike{
    WEAKSELF;
    [NetworkTool serviceInfoAgreeWithId:_Id type:2 succeedBlock:^(NSDictionary * _Nullable result) {
        [weakSelf likeSucceed:[result objectForKey:kData]];
    } failedBlock:^(id  _Nullable errorInfo) {
        [WTAlertView showMessage:[errorInfo objectForKey:kMessage]];
    }];
}

- (void)likeSucceed:(NSArray *)array{
    
}

#pragma mark --点击评论内容的某一行
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath{
    
    CommentCellModel *model = self.dataArray[secIndexPath.row];
    CommentModel *comModel = model.commentArray[secIndexPath.row];
    if([comModel.userName isEqualToString:[UserStatus shareInstance].nickName]){
        
        [CommonTools alertWithTitle:nil message:@"是否删除该条评论" style:UIAlertControllerStyleAlert leftBtnTitle:@"取消" rightBtnTitle:@"好的" rootVc:self leftClick:^{
            
        } rightClick:^{
            NSMutableArray *mutableArray = model.commentArray.mutableCopy;
            [mutableArray removeObjectAtIndex:secIndexPath.row];
            model.commentArray = mutableArray.copy;
            [self.tableView reloadRowsAtIndexPaths:@[firIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    else{
        self.commentIndexpath = firIndexPath;
        self.replyIndexpath = secIndexPath;
//        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复：%@",comModel.userName];
//        [self.chatKeyBoard keyboardUpforComment];
        [_bottomView.commentTextField becomeFirstResponder];
    }
}

#pragma mark -- 点击图片
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //收取键盘
    if (_bottomView.commentTextField.isFirstResponder) {
        [_bottomView.commentTextField resignFirstResponder];
    }
}


#pragma mark - lazy
- (ServiceInfoDetailHeader *)header{
    if (!_header) {
        _header = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ServiceInfoDetailHeader class]) owner:nil options:nil].firstObject;
        _tableView.tableHeaderView = _header;
    }
    return _header;
}

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
