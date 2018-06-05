//
//  NetworkTool.h
//  SmarkPark
//
//  Created by SandClock on 2018/3/13.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonNetwork.h"

@interface NetworkTool : NSObject

/**
 验证码
 */
+ (NSURLSessionDataTask *)getVerifyCodeWithPhone:(NSString *)phone succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;


/**
 验证码验证
 */
+ (NSURLSessionDataTask *)codeVerifyWithPhone:(NSString *)mobile purpose:(NSString *)purpose code:(NSString *)code succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 注册
 */
+ (NSURLSessionDataTask *)signupWithMobile:(NSString *)mobile psd:(NSString *)psd succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 登录
 */
+ (NSURLSessionDataTask *)loginWithMobile:(NSString *)mobile psd:(NSString *)psd succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 个人信息
 */
+ (NSURLSessionDataTask *)getUserInfoWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 个人菜单
 */
+ (NSURLSessionDataTask *)getUserMenuWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 我的住所菜单
 */
+ (NSURLSessionDataTask *)getUserFlatWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 首页轮播
 */
+ (NSURLSessionDataTask *)getHomeBannerWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;
/**
 服务轮播
 */
+ (NSURLSessionDataTask *)getServiceBannerWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 社区活动列表
 */
+ (NSURLSessionDataTask *)getCommunityActivitiesWithPageIndex:(NSInteger)pageIndex count:(NSInteger)count SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

@end
