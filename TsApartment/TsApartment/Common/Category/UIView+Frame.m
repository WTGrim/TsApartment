//
//  UIView+Frame.m
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGSize)wt_size{
    return self.frame.size;
}

- (void)setWt_size:(CGSize)wt_size{
    self.frame = CGRectMake(self.wt_x, self.wt_y, wt_size.width, wt_size.height);
}

- (CGFloat)wt_width{
    return self.wt_size.width;
}

- (void)setWt_width:(CGFloat)wt_width{
    self.frame = CGRectMake(self.wt_x, self.wt_y, wt_width, self.wt_height);
}

- (CGFloat)wt_height{
    return self.wt_size.height;
}

- (void)setWt_height:(CGFloat)wt_height{
    self.frame = CGRectMake(self.wt_x, self.wt_y, self.wt_width, wt_height);
}

- (CGFloat)wt_x{
    return self.frame.origin.x;
}

- (void)setWt_x:(CGFloat)wt_x{
    self.frame = CGRectMake(wt_x, self.wt_y, self.wt_width, self.wt_height);
}

- (CGFloat)wt_y{
    return self.frame.origin.y;
}

- (void)setWt_y:(CGFloat)wt_y{
    self.frame = CGRectMake(self.wt_x, wt_y, self.wt_width, self.wt_height);
}

- (CGFloat)wt_bottomY{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)wt_rightX{
    return CGRectGetMaxX(self.frame);
}

- (void)setWt_rightX:(CGFloat)wt_rightX{
    self.frame = CGRectMake(wt_rightX - self.wt_width, self.wt_y, self.wt_width, self.wt_height);
}

- (CGFloat)wt_centerX{
    return self.center.x;
}

- (void)setWt_centerX:(CGFloat)wt_centerX{
    self.center = CGPointMake(wt_centerX, self.center.y);
}

- (CGFloat)wt_centerY{
    return self.center.y;
}

- (void)setWt_centerY:(CGFloat)wt_centerY{
    self.center = CGPointMake(self.center.x, wt_centerY);
}

@end
