//
//  CommonBtn.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommonBtn.h"

@implementation CommonBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    CGRect imageViewFrame = self.imageView.frame;
    CGRect titleLabelFrame = self.titleLabel.frame;
    CGFloat totalHeight = CGRectGetHeight(self.imageView.frame) + CGRectGetHeight(self.titleLabel.frame) + 8;
    imageViewFrame.origin.y = (CGRectGetHeight(self.frame) - totalHeight) / 2.0;
    imageViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(imageViewFrame))/ 2.0;
    self.imageView.frame = imageViewFrame;
    titleLabelFrame.origin.y = CGRectGetMaxY(imageViewFrame) + 8;
    titleLabelFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(titleLabelFrame))/ 2.0;
    self.titleLabel.frame = titleLabelFrame;
}


@end


#define MESSAGE_W 10
@implementation MessageBtn{
    UILabel *badgeLabel;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self createBadgeLabel];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBadgeLabel];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self createBadgeLabel];
    }
    return self;
}

- (void)createBadgeLabel{
    badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 12, 0, 16, 16)];
    badgeLabel.layer.cornerRadius = 8;
    badgeLabel.clipsToBounds = YES;
    badgeLabel.backgroundColor = [UIColor redColor];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.font = [UIFont boldSystemFontOfSize:9];
    badgeLabel.hidden = YES;
    [self addSubview:badgeLabel];
}

- (void)setBadgeNumber:(NSInteger)badgeNumber{
    _badgeNumber = badgeNumber;
    if (badgeNumber == 0) {
        badgeLabel.text = @"0";
        badgeLabel.hidden = YES;
    }else {
        badgeLabel.text = [NSString stringWithFormat:@"%ld",(long)_badgeNumber];
        badgeLabel.hidden = NO;
    }
}

- (void)setBadgeHidden:(BOOL)badgeHidden{
    _badgeHidden = badgeHidden;
    badgeLabel.hidden = _badgeHidden;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!StringIsNull(self.currentTitle)) {
        CGRect frame = self.frame;
        CGRect imgFrame = self.imageView.frame;
        imgFrame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
        self.imageView.frame = imgFrame;
        self.imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - imgFrame.size.height * 0.2);
        
        CGRect labelFrame = self.titleLabel.frame;
        labelFrame = CGRectMake(0, CGRectGetMidY(self.bounds) + 8, frame.size.width, 14);
        self.titleLabel.frame = labelFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    CGRect frame = self.imageView.frame;
    badgeLabel.frame = CGRectMake(frame.origin.x + MESSAGE_W * 0.5, frame.origin.y - 6, MESSAGE_W, MESSAGE_W);
}

@end


@implementation ListHeaderBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    
    titleF.origin.x = (CGRectGetWidth(self.frame) - (CGRectGetWidth(self.titleLabel.frame) +  CGRectGetWidth(self.imageView.frame))) * 0.5;
    self.titleLabel.frame = titleF;
    
    imageF.origin.x = CGRectGetMaxX(titleF) ;
    self.imageView.frame = imageF;
}

@end
