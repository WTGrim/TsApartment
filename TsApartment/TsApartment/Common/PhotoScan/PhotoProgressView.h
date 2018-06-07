//
//  PhotoProgressView.h
//  PhotoScan
//
//  Created by Dwt on 2017/1/6.
//  Copyright © 2017年 Dwt. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProgressStyle_Pie = 0,
    ProgressStyle_annulus,
} ProgressStyle;

@interface PhotoProgressView : UIView

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)ProgressStyle style;
@end
