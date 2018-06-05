//
//  UserStatus.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "UserStatus.h"

@implementation UserStatus

+ (instancetype)shareInstance{
    static UserStatus *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserStatus alloc]init];
    });
    return user;
}

- (void)initWithDict:(NSDictionary *)dict{
    _isLogin = true;
    if (dict[kMobile]) {
        _mobile = dict[kMobile];
    }
    if (dict[kSid]) {
        _sid = dict[kSid];
    }
    if (dict[kUid]) {
        _uid = dict[kUid];
    }
    if (dict[kSex]) {
        _sex = dict[kSex];
    }
    if (dict[kNickName]) {
        _nickName = dict[kNickName];
    }
}

- (NSDictionary *)userInfoDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if (!StringIsNull(_mobile)) {
        [dict setObject:_mobile forKey:kMobile];
    }
    if (!StringIsNull(_sid)) {
        [dict setObject:_sid forKey:kSid];
    }
    if (!StringIsNull(_uid)) {
        [dict setObject:kUid forKey:kUid];
    }
    if (!StringIsNull(_nickName)) {
        [dict setObject:_nickName forKey:kNickName];
    }
    if (!StringIsNull(_sex)) {
        [dict setObject:_sex forKey:kSex];
    }
    return dict;
}

- (void)destoryUserStatus {
    _isLogin = NO;
    _mobile = nil;
    _sid = nil;
    _nickName = nil;
    _sex = nil;
}

@end
