//
//  UIView+Frame.h
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**快速返回size*/
@property (nonatomic, assign) CGSize wt_size;
/**快速返回宽度*/
@property (nonatomic, assign) CGFloat wt_width;
/**快速返回高度*/
@property (nonatomic, assign) CGFloat wt_height;
/**快速返回x*/
@property (nonatomic, assign) CGFloat wt_x;
/**快速返回y*/
@property (nonatomic, assign) CGFloat wt_y;

@property (nonatomic, assign) CGFloat wt_centerX;

@property (nonatomic, assign) CGFloat wt_centerY;
/**快速返回右边*/
@property (nonatomic, assign) CGFloat wt_rightX;
/**快速返回底部*/
@property (nonatomic, assign, readonly) CGFloat wt_bottomY;
@end
