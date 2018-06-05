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

+ (NSURLSessionDataTask *)getUserInfoWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@user/info",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getUserMenuWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSString *url = [NSString stringWithFormat:@"%@user/data/nav",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:nil showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getUserFlatWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSString *url = [NSString stringWithFormat:@"%@user/data/home_nav",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:nil showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getHomeBannerWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSString *url = [NSString stringWithFormat:@"%@home/data/banner",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:nil showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getServiceBannerWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSString *url = [NSString stringWithFormat:@"%@service/data/banner",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:nil showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getCommunityActivitiesWithPageIndex:(NSInteger)pageIndex count:(NSInteger)count SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pagination = [[NSMutableDictionary alloc]init];
    [pagination setObject:@(pageIndex) forKey:kPage];
    [pagination setObject:@(count) forKey:kCount];
    [param setObject:pagination forKey:kPagination];
    NSString *url = [NSString stringWithFormat:@"%@home/activity/list",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}



@end
