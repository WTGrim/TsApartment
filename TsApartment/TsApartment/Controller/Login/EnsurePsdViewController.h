//
//  EnsurePsdViewController.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicViewController.h"

typedef NS_ENUM(NSUInteger, EnsurePsdType) {
    EnsurePsdType_Signup,
    EnsurePsdType_FindPsd
};

@interface EnsurePsdViewController : BasicViewController

@property(nonatomic, assign)EnsurePsdType type;
@property(nonatomic, copy)NSString *mobile;

@end
