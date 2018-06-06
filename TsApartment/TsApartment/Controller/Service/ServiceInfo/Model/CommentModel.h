//
//  CommentModel.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *replyUserName;
@property (nonatomic,copy)NSString *content;
@end
