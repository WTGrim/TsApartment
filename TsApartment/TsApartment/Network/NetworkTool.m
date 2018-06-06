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
    NSString *url = [NSString stringWithFormat:@"%@user/signin",SERVER_IP];
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

//+ (NSURLSessionDataTask *)editUserInfoWithNickName:(NSString *)nickName sex:(NSString *)sex file:(id)files password:(NSString *)password SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
//    
//    
//}

+ (NSURLSessionDataTask *)getCommunityActivitiesWithPageIndex:(NSInteger)pageIndex count:(NSInteger)count SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pagination = [[NSMutableDictionary alloc]init];
    [pagination setObject:@(pageIndex) forKey:kPage];
    [pagination setObject:@(count) forKey:kCount];
    [param setObject:pagination forKey:kPagination];
    NSString *url = [NSString stringWithFormat:@"%@home/activity/list",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getCommunityActivityDetailWithId:(NSInteger)Id SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(Id) forKey:kId];
    NSString *url = [NSString stringWithFormat:@"%@home/activity/detail",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getCommunityActivityJoin_listDetailWithId:(NSInteger)Id pageIndex:(NSInteger)pageIndex count:(NSInteger)count SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pagination = [[NSMutableDictionary alloc]init];
    [pagination setObject:@(pageIndex) forKey:kPage];
    [pagination setObject:@(count) forKey:kCount];
    [param setObject:pagination forKey:kPagination];
    [param setObject:@(Id) forKey:kId];

    NSString *url = [NSString stringWithFormat:@"%@home/activity/join_list",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getServiceMenuWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSString *url = [NSString stringWithFormat:@"%@service/data/nav",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:nil showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)serviceApplyWithId:(NSInteger)Id Name:(NSString *)name mobile:(NSString *)mobile num:(NSInteger )num SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(Id) forKey:kId];
    [param setObject:name forKey:kUsername];
    [param setObject:mobile forKey:kMobile];
    [param setObject:@(num) forKey:kNumber];
    
    NSString *url = [NSString stringWithFormat:@"%@home/activity/join",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getServiceInfoDetailWithId:(NSInteger)Id succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(Id) forKey:kId];
    
    NSString *url = [NSString stringWithFormat:@"%@service/information/detail",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getServiceInfoListWithPageIndex:(NSInteger)PageIndex succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pagination = [[NSMutableDictionary alloc]init];
    [pagination setObject:@(PageIndex) forKey:kPage];
    [pagination setObject:@(COMMON_PAGE_SIZE) forKey:kCount];
    [param setObject:pagination forKey:kPagination];
    NSString *url = [NSString stringWithFormat:@"%@service/information/list",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)getServiceInfo_commentListWithId:(NSInteger)Id pageIndex:(NSInteger)pageIndex succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pagination = [[NSMutableDictionary alloc]init];
    [pagination setObject:@(pageIndex) forKey:kPage];
    [pagination setObject:@(COMMON_PAGE_SIZE) forKey:kCount];
    [param setObject:pagination forKey:kPagination];
    [param setObject:@(Id) forKey:kId];
    NSString *url = [NSString stringWithFormat:@"%@service/information/comment_list",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)serviceInfoComment_submitWithId:(NSInteger)Id content:(NSString *)content ip_address:(NSString *)ip_address parent_id:(NSInteger)parent_id succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(Id) forKey:kId];
    [param setObject:content forKey:kContent];
    [param setObject:@"" forKey:@"ip_address"];
    [param setObject:@(parent_id) forKey:kParent_id];
    NSString *url = [NSString stringWithFormat:@"%@service/information/comment_submit",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)serviceInfoAgreeWithId:(NSInteger)Id type:(NSInteger)type succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@(Id) forKey:kId];
    [param setObject:@(type) forKey:kType];
    NSString *url = [NSString stringWithFormat:@"%@service/information/agree",SERVER_IP];
    return [CommonNetwork postDataWithUrl:url param:param showLoader:true showAlert:true gZip:NO succeedBlock:succeed failedBlock:failed];
}

+ (NSURLSessionDataTask *)editUserInfoWithNickName:(NSString *)nickName sex:(NSInteger)sex imageArray:(NSArray *)imageArray password:(NSString *)password SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if (nickName) {
        [param setObject:nickName forKey:kNickName];
    }
    if (sex) {
        [param setObject:@(sex) forKey:kSex];
    }
    if (password) {
        [param setObject:password forKey:kPassword];
    }
    NSString *url = [NSString stringWithFormat:@"%@user/edit/basicinfo",SERVER_IP];
    return [CommonNetwork uploadWithUrl:url param:param imageArray:imageArray showLoader:true showAlert:true progress:nil gZip:false succeedBlock:succeed failedBlock:failed];
}



@end
