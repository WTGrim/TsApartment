//
//  CircumDetailCommentCell.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicTableViewCell.h"
@protocol CircumDetailCommentCellDelegate <NSObject>
- (void)reloadCell:(CGFloat)height indexPath:(NSIndexPath *)indexPath;
@end

typedef void(^CellHeightBlock)(CGFloat cellHeight);

@interface CircumDetailCommentCell : BasicTableViewCell
//设置数据
- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath cellHeight:(void(^)(CGFloat height))cellHeight;
//代理
@property(nonatomic, weak)id<CircumDetailCommentCellDelegate> delegate;
//高度回调
@property(nonatomic, copy)CellHeightBlock cellHeightBlock;

@end
