//
//  MessageView.h
//  TsApartment
//
//  Created by SandClock on 2018/5/28.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView

/**红点是否隐藏*/
@property(nonatomic, assign)BOOL spotHidden;

- (instancetype)initWithFrame:(CGRect)frame onClick:(void(^)(void))onClick;
@end
