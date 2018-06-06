//
//  ServiceInfoDetailHeader.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/6.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceInfoDetailHeader : UIView

- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void(^)(CGFloat height))heightCallBack;

@end
