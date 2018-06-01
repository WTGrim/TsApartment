//
//  CommonMacro.h
//  SmarkPark
//
//  Created by SandClock on 2018/5/25.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


// ===================== 弱指针 =====================
#define WeakSelf(type) __weak typeof(type) weak##type = type

#define WEAKSELF typeof(self) __weak weakSelf = self
#define STRONGSELF typeof(self) __strong strongSelf = self;

// ===================== 链接字符串 ===================
#define ConnectString(str) [NSString stringWithFormat:@"%@", @#str]

// ===================== 系统相关 =====================
#define APP_DELEGATE() ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) ? YES : NO)
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 7)
#define IsIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 8.0)
#define IsIOS9 (([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 9.0) && [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<10.0)
#define IsIOS10 ([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)

// ==================== App Version ====================
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//手机序列号
#define Device_UUID [[UIDevice currentDevice].identifierForVendor UUIDString]
/** documentPath */
#define DocumentPath  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
/** cachesPath */
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]
/** librabyPath */
#define LibraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject]
/** tmpPath */
#define TmpPath NSTemporaryDirectory()

// ===================== 尺寸相关 =====================
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH SCREEN_SIZE.width
#define SCREEN_HEIGHT SCREEN_SIZE.height
#define KeyWindow [UIApplication sharedApplication].keyWindow
#define FONT(fSize) [UIFont systemFontOfSize:(fSize)]
#define SAFE_NAV_HEIGHT ([CommonTools isIphoneX] ? 88 : 64)
#define SAFE_BOTTOM_HEIGHT ([CommonTools isIphoneX] ? 83 : 49)


// ===================== 颜色相关 =====================
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ThemeColor_Nav RGB(40, 222, 234)
#define ThemeColor_Background RGB(244, 244, 244)
#define ThemeColor_BlackText RGB(40, 40, 40)
#define ThemeColor_GrayText RGB(120, 120, 120)
#define ThemeColor_lightBg RGB(240, 240, 240)
#define ThemeColor_line RGB(230, 230, 230)
#define ThemeColor_HomeLine RGB(245, 205, 100)


#endif /* CommonMacro_h */
