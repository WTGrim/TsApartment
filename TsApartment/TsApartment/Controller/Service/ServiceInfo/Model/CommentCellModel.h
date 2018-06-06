//
//  CommentCellModel.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCellModel : UIView

@property (nonatomic,copy)NSString *usernName;
@property (nonatomic,copy)NSString *headImgName;
@property (nonatomic,copy)NSString *msgContent;
@property (nonatomic,strong)NSArray *picNameArray;

@property (nonatomic,strong)NSArray *likeNameArray;
@property (nonatomic,strong)NSArray *commentArray;

@property (nonatomic,assign)BOOL isLiked;
///发布说说的展开状态
@property (nonatomic, assign) BOOL isExpand;

@end
