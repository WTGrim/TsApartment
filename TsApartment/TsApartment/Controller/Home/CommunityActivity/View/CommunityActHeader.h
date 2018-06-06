//
//  CommunityActHeader.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityActHeader : UIView

- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void(^)(CGFloat height))heightCallBack;
//报名成功回调
@property(nonatomic, copy)void(^applySucceedCallBack)(void);

@end
