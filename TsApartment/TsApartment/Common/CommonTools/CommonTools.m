//
//  CommonTools.m
//  37℃Apartment
//
//  Created by SandClock on 2018/5/23.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommonTools.h"
#import "sys/utsname.h"


@implementation CommonTools

BOOL StringIsNull(NSString *string) {
    if (string == nil) {
        return YES;
    } else if ([string isEqual:[NSNull null]]) {
        return YES;
    }else if (string.length == 0) {
        return YES;
    }else if ([string isEqualToString:@"(null)"]) {
        return YES;
    } else if ([string isEqualToString:@"<null>"]) {
        return YES;
    } else if ([[string class] isEqual:[NSNull class]]) {
        return YES;
    }
    return NO;
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle rootVc:(UIViewController *)rootVc leftClick:(void (^)(void))leftClick rightClick:(void (^)(void))rightClick{
    
    [self alertWithTitle:title message:message style:style leftStyle:UIAlertActionStyleDefault rightStyle:UIAlertActionStyleDefault leftBtnTitle:leftBtnTitle rightBtnTitle:rightBtnTitle rootVc:rootVc leftClick:leftClick rightClick:rightClick];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style leftStyle:(UIAlertActionStyle)leftStyle rightStyle:(UIAlertActionStyle)rightStyle leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle rootVc:(UIViewController *)rootVc leftClick:(void (^)(void))leftClick rightClick:(void (^)(void))rightClick{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:leftBtnTitle style:leftStyle handler:^(UIAlertAction * _Nonnull action) {
        if (leftClick) {
            leftClick();
        }
    }];
    
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:rightBtnTitle style:rightStyle handler:^(UIAlertAction * _Nonnull action) {
        if (rightClick) {
            rightClick();
        }
    }];
    
    [alert addAction:cancel];
    [alert addAction:ensure];
    [rootVc presentViewController:alert animated:YES completion:nil];
}

+ (BOOL)isIphoneX{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([machineString isEqualToString:@"iPhone10,3"])return YES;
    if ([machineString isEqualToString:@"iPhone10,6"]) return YES;
    if (SCREEN_HEIGHT == 812)return YES;
    return NO;
}

+ (BOOL)isTelNumber:(NSString *)phoneNo{
    if (phoneNo.length == 11 && [[phoneNo substringToIndex:1] integerValue] == 1) {
        return YES;
    }
    return NO;
}

+ (UIViewController *)findViewController:(UIView *)sourceView {
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

+(void)saveLocalWithKey:(NSString*)key Obj:(id)obj
{
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:obj forKey:key];//设置值
    [[NSUserDefaults standardUserDefaults] synchronize]; //手动保存
}

+(void)removeLocalWithKey:(NSString*)key
{
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];//设置值
    [[NSUserDefaults standardUserDefaults] synchronize]; //手动保存
}

+(id)loadLocalWithKey:(NSString*)key
{
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:key];
}

+ (NSString *)getStringWithDict:(NSDictionary *)dict key:(NSString *)key{
    if (StringIsNull([dict objectForKey:key])) {
        return @"";
    }
    return [dict objectForKey:key];
}

+ (BOOL)isFit2xImg{
    
    if ([CommonTools isIphoneX]) {
        return false;
    }
    if (SCREEN_WIDTH > 750) {
        return false;
    }
    return true;
}

+ (NSAttributedString *)getAttrWithString:(NSString *)string attr:(NSDictionary *)attr range:(NSRange)range{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:string];
    [att addAttributes:attr range:range];
    return att;
}

+ (NSString *)getFitImgName{
    if ([CommonTools isFit2xImg]) {
        return kImgurl2;
    }
    return kImgurl3;
}

+ (NSString *)dealMobileString:(NSString *)mobile{
    if ([CommonTools isTelNumber:mobile]) {
        NSString *string = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return string;
    }
    return mobile;
}

@end
