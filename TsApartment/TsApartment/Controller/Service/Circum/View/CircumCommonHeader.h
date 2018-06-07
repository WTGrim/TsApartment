//
//  CircumCommonHeader.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircumCommonHeader : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles heightCallBack:(void(^)(CGFloat height))heightCallBack;

@end
