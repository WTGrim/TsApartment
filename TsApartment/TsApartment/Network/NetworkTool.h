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
@end
