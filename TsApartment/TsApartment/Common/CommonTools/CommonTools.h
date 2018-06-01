//
//  CommonTools.h
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject

/**判断字符串是否为空*/
BOOL StringIsNull(NSString *string);

/**系统提示框*/
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle rootVc:(UIViewController *)rootVc leftClick:(void(^)(void))leftClick rightClick:(void(^)(void))rightClick;

/**自定义系统提示框*/
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style leftStyle:(UIAlertActionStyle)leftStyle rightStyle:(UIAlertActionStyle)rightStyle leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle rootVc:(UIViewController *)rootVc leftClick:(void(^)(void))leftClick rightClick:(void(^)(void))rightClick;

//判断是否是iPhone X
+ (BOOL)isIphoneX;

//检查是否为电话
+ (BOOL)isTelNumber:(NSString *)phoneNo;

//缓存信息
+(void)saveLocalWithKey:(NSString*)key Obj:(id)obj;

//删除缓存
+(void)removeLocalWithKey:(NSString*)key;
@end
