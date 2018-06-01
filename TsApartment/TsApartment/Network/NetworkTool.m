//
//  NetworkTool.m
//  SmarkPark
//
//  Created by SandClock on 2018/3/13.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "NetworkTool.h"
#import "JSONKit.h"
#import <UIKit/UIKit.h>

@implementation NetworkTool

+ (NSURLSessionDataTask *)getVerifyCodeWithPhone:(NSString *)phone succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSInteger mobile = [phone integerValue];
    [param setObject:@(mobile) forKey:kMobile];
    [param setObject:@"register" forKey:kPurpose];
    NSString *url = [NSString stringWithFormat:@"%@message/index/send",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)codeVerifyWithPhone:(NSString *)mobile purpose:(NSString *)purpose code:(NSString *)code succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSInteger mobileNo = [mobile integerValue];
    [param setObject:@(mobileNo) forKey:kMobile];
    [param setObject:@"register" forKey:kPurpose];
    [param setObject:code forKey:kCode];
    NSString *url = [NSString stringWithFormat:@"%@message/index/check",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)signupWithMobile:(NSString *)mobile psd:(NSString *)psd succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSInteger mobileNo = [mobile integerValue];
    [param setObject:@(mobileNo) forKey:kMobile];
    [param setObject:psd forKey:kPassword];
    NSString *url = [NSString stringWithFormat:@"%@user/signup",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)loginWithMobile:(NSString *)mobile psd:(NSString *)psd succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSInteger mobileNo = [mobile integerValue];
    [param setObject:@(mobileNo) forKey:kMobile];
    [param setObject:psd forKey:kPassword];
    NSString *url = [NSString stringWithFormat:@"%@user/sigin",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

@end
