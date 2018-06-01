//
//  LocationChooseController.h
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicViewController.h"

@interface LocationChooseController : BasicViewController

//地址选择回调
@property(nonatomic, copy)void(^chooseCity)(NSString *city);

@end
