//
//  WTAlertView.h
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTAlertView;

@protocol WTAlertViewDelegate <NSObject>
@optional
- (void)wtAlertView:(WTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface WTAlertView : UIView

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;
//+ (void)showMessage:(NSString *)message image:(UIImage *)image;
//+ (void)showMessage:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image alertViewDelegate:(id<WTAlertViewDelegate>)delegate cancelButton:(NSString *)cancel otherButton:(NSString *)otherStr,...__attribute__((sentinel(0,1)));
@end
