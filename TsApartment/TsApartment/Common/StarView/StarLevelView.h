//
//  StarLevelView.h
//  HormoneSportsClient
//
//  Created by Dwt on 2017/6/30.
//  Copyright © 2017年 HormoneSports. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletedBlock)(CGFloat currentScore);
typedef NS_ENUM(NSUInteger, StarStyle) {
    StarStyleCustom,    //不完整评分
    StarStyleWhole      //整星评分
};
@interface StarLevelView : UIView

@property(nonatomic, assign)CGFloat externalScore;
@property(nonatomic, copy)CompletedBlock completed;
@property(nonatomic, assign)BOOL tapEnable;
@property(nonatomic, assign)StarStyle style;    //默认是不完整平分

- (instancetype)initWithFrame:(CGRect)frame animated:(BOOL)animate;


@end
