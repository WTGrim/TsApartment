//
//  CommunityActHeader.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/5.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommunityActHeader.h"
#import <WebKit/WebKit.h>

@interface CommunityActHeader ()

@property (weak, nonatomic) IBOutlet UIView *cycleBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *webBgView;

@property (weak, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *joinNum;

@end

@implementation CommunityActHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setHeaderWithDict:(NSDictionary *)dict heightCallBack:(void (^)(CGFloat))heightCallBack{
    
}

- (void)setupUI{
    _applyView.layer.cornerRadius = 5;
    _applyView.layer.masksToBounds = true;
    _applyView.layer.shadowOpacity = 0.4;
    _applyView.layer.shadowOffset = CGSizeZero;
    _applyView.layer.shadowColor = RGBA(0, 0, 0, 0.4).CGColor;
}

//报名
- (IBAction)applyClick:(UIButton *)sender {
    
    
}

@end
