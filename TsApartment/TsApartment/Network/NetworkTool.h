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
 用户信息修改
 */
+ (NSURLSessionDataTask *)editUserInfoWithNickName:(NSString *)nickName sex:(NSInteger)sex imageArray:(NSArray *)imageArray password:(NSString *)password SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

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

/**
 社区活动列表
 */
+ (NSURLSessionDataTask *)getCommunityActivityDetailWithId:(NSInteger)Id SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 社区活动列表
 */
+ (NSURLSessionDataTask *)getCommunityActivityJoin_listDetailWithId:(NSInteger)Id pageIndex:(NSInteger)pageIndex count:(NSInteger)count SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 服务菜单
 */
+ (NSURLSessionDataTask *)getServiceMenuWithSucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 资讯详情
 */
+ (NSURLSessionDataTask *)getServiceInfoDetailWithId:(NSInteger)Id succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 服务资讯列表
 */
+ (NSURLSessionDataTask *)getServiceInfo_commentListWithId:(NSInteger)Id pageIndex:(NSInteger)pageIndex succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 评论列表
 */
+ (NSURLSessionDataTask *)getServiceInfoListWithPageIndex:(NSInteger)PageIndex succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

/**
 发布评论
 */
+ (NSURLSessionDataTask *)serviceInfoComment_submitWithId:(NSInteger)Id content:(NSString *)content ip_address:(NSString *)ip_address parent_id:(NSInteger )parent_id succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;
/**
 点赞和取消点赞
 */
+ (NSURLSessionDataTask *)serviceInfoAgreeWithId:(NSInteger)Id type:(NSInteger)type succeedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;
/**
 活动报名
 */
+ (NSURLSessionDataTask *)serviceApplyWithId:(NSInteger)Id Name:(NSString *)name mobile:(NSString *)mobile num:(NSInteger)num SucceedBlock:(RequestSucceed)succeed failedBlock:(RequestFailed)failed;

@end
