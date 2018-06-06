//
//  CommentBottomView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewTextField.h"

@interface CommentBottomView : UIView
//评论框
@property(nonatomic, strong)CommentTextField *commentTextField;
//发布
@property(nonatomic, copy)void(^publicCallBack)(NSString *comment);

@end
