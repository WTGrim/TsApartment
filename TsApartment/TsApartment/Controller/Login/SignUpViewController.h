//
//  SignUpViewController.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicViewController.h"

typedef NS_ENUM(NSUInteger, SignupType) {
    SignupType_Signup,
    SignupType_FindPsd
};

@interface SignUpViewController : BasicViewController

@property(nonatomic, assign)SignupType type;

@end
