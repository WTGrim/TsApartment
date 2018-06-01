//
//  UserStatus.h
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStatus : NSObject

/** 是否登录 */
@property (assign, nonatomic) BOOL isLogin;
/** 用户登录token*/
@property (copy, nonatomic) NSString *sid;
/** 用户手机号*/
@property (copy, nonatomic) NSString *mobile;
/** 用户性别*/
@property (copy, nonatomic) NSString *sex;
/** 用户昵称*/
@property (copy, nonatomic) NSString *nickName;

// 初始化
+ (instancetype)shareInstance;

// 生成用户数据
- (void)initWithDict:(NSDictionary *)dict;

//获取用户信息的字典
- (NSDictionary *)userInfoDict;

// 销毁用户信息
- (void)destoryUserStatus;

@end
