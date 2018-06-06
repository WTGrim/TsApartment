//
//  CommonCommentCell.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentCellModel;
@class OperationView;

@protocol CommonCommentCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end

@interface CommonCommentCell : UITableViewCell

@property (nonatomic,weak)id <CommonCommentCellDelegate>delegate;

@property (nonatomic,strong)OperationView *operationView;
- (void)setCellWithModel:(CommentCellModel *)model indexPath:(NSIndexPath *)indexPath;

@end
