//
//  BadgeSegment.h
//  SegmentDemo
//
//  Created by SandClock on 2018/5/25.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeSegment : UIView


- (void)setTitles:(NSArray *)titles badges:(NSArray *)badges didSelected:(void(^)(NSInteger index))didSelected;

@end
