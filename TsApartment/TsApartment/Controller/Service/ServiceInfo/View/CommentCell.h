//
//  CommentCell.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;

@interface CommentCell : UITableViewCell

- (void)setCellWithModel:(CommentModel *)model;

@end
