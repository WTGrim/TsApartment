//
//  CircumPageViewController.h
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BasicViewController.h"
#import "PageScrollViewDelegate.h"

@interface CircumPageViewController : BasicViewController <ScrollPageViewChildVcDelegate>

@property(nonatomic, copy)NSDictionary *paramDict;

@end
