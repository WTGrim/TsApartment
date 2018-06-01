//
//  HomeLocationView.h
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLocationView : UIView

/**城市名称*/
@property(nonatomic, copy)NSString *cityName;

- (instancetype)initWithFrame:(CGRect)frame onClick:(void(^)(void))onClick;

@end
