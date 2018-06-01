//
//  BadgeSegment.m
//  SegmentDemo
//
//  Created by SandClock on 2018/5/25.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "BadgeSegment.h"
#import "SegmentItem.h"

#define ITEM_TAG 100

@interface BadgeSegment()

@property(nonatomic, copy)void(^didSelected)(NSInteger index);

@end

@implementation BadgeSegment{
    NSArray *_titles;
    NSArray *_badges;
    SegmentItem *_currentItem;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setTitles:(NSArray *)titles badges:(NSArray *)badges didSelected:(void (^)(NSInteger))didSelected{
    
    CGFloat w = CGRectGetWidth(self.frame) / titles.count;
    CGFloat h = CGRectGetHeight(self.frame);
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SegmentItem *item = [[SegmentItem alloc]initWithFrame:CGRectMake(w * idx, 0, w, h)];
        item.title = titles[idx];
        item.tag = ITEM_TAG + idx;
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)]];
        [self addSubview:item];
    }];
}

#pragma mark - 点击事件
- (void)itemClick:(UITapGestureRecognizer *)tap{
    
    SegmentItem *item = (SegmentItem *)tap.view;
    if (item == _currentItem)return;
    [self setIsSelectedStatus:true item:item];
    [self setIsSelectedStatus:false item:_currentItem];
    _currentItem = item;
    if (_didSelected) {
        _didSelected(item.tag - ITEM_TAG);
    }
}

- (void)setIsSelectedStatus:(BOOL)isSelected item:(SegmentItem *)item{
    item.isSelected =  isSelected;
    
}

@end
