//
//  BasicViewController.h
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LoadStatus) {
    LoadStatusBeginLoad,
    LoadStatusBadNetwork,
    LoadStatusSucceed,
    LoadStatusNoData,
    LoadStatusFailed,
    LoadStatusLocationDisabled
};


@interface BasicViewController : UIViewController

/** 页面加载状态 */
@property (assign, nonatomic) LoadStatus loadStatus;
/** 隐藏返回按钮 */
@property (assign, nonatomic) BOOL backItemHidden;
// 登陆状态改变
- (void)loginStatusChanged;
//返回按钮点击事件
- (void)navigationBackItemClicked;
//弹出登录提示框
- (void)showLoginAlert;
//隐藏bar底部线
- (void)setNavigationBarShadowHidden;

@end
