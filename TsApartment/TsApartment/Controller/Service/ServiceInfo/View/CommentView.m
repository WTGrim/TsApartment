//
//  CommentView.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommentView.h"
#import "CommentCell.h"
#import "CommentCellModel.h"
#import "CommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MLLinkLabel.h"
#import <Masonry.h>

@interface CommentView()<UITableViewDelegate,UITableViewDataSource,MLLinkLabelDelegate>
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)UIImageView *bigImageView;
@property (nonatomic,strong)MLLinkLabel *praiseLabel;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation CommentView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    
    [self addSubview:tableView];
    self.tableView = tableView;
    //        [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    //        }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height=  [CommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CommentCell *cell = (CommentCell *)sourceCell;
        [cell setCellWithModel:self.commentDataArray[indexPath.row]];
    } ];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentCell class])];
    if(cell==nil)
    {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommentCell class])];
        //  cell.delegate = self;
    }
    cell.backgroundColor = RGB(240, 240, 240);;
    [cell setCellWithModel:self.commentDataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)]){
        [_delegate didClickRowWithFirstIndexPath:self.indexPath secondIndex:indexPath];
    }
}

- (void)configCellWithModel:(CommentCellModel *)model indexPath:(NSIndexPath *)indexPath{
    self.commentDataArray = [NSMutableArray arrayWithArray:model.commentArray];
    self.likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    self.indexPath = indexPath;
    [self setPraiseLabelTextWithLikeArray:model.likeNameArray];
    [self.tableView reloadData];
    CGFloat height;
    for(CommentModel *model in self.commentDataArray){
        float cellHeight = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            CommentCell *cell = (CommentCell *)sourceCell;
            [cell setCellWithModel:model];
        }];
        height += cellHeight;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
}

-(void)setPraiseLabelTextWithLikeArray:(NSArray *)array{
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    for(int i = 0;i < array.count; i++)
    {
        NSString *string = array[i];
        if(i > 0){
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString setAttributes:@{ NSLinkAttributeName :string} range:[string rangeOfString:string]];
        [attributedText appendAttributedString:attString];
    }
    self.praiseLabel.attributedText = [attributedText copy];
}

- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel{
    NSLog(@"点击了：%@",link.linkValue);
}



@end
