//
//  CommentView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@class CommentCellModel;

@protocol CommentViewDelegate <NSObject>

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end

@interface CommentView : UIView

- (void)configCellWithModel:(CommentCellModel *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) id <CommentViewDelegate>delegate;

@end
