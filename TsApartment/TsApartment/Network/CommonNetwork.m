//
//  CommonNetwork.m
//  SmarkPark
//
//  Created by SandClock on 2018/3/12.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CommonNetwork.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "UserStatus.h"
#import <CommonCrypto/CommonCrypto.h>
#import <zlib.h>

#define kTimeOutInterval 10

#define AuthFlag  @""

static NSString *const kJsonType = @"application/json";

@implementation CommonNetwork

+ (NSURLSessionDataTask *)postDataWithUrl:(NSString *)url param:(id )params showLoader:(BOOL)showLoader showAlert:(BOOL)showAlert gZip:(BOOL)gZip succeedBlock:(RequestSucceed)succeedBlock failedBlock:(RequestFailed)failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    //    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:kJsonType forHTTPHeaderField:@"Content-Type"];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    if ([UserStatus shareInstance].isLogin) {
//        [manager.requestSerializer setValue:[UserStatus shareInstance].sid forHTTPHeaderField:@"Authorization"];
        NSMutableArray *finalParam = [NSMutableArray array];
        finalParam = [params mutableCopy];
        [finalParam setValue:[UserStatus shareInstance].sid forKey:kSession];
    }
    if (showLoader) {
        [AlertView showProgress];
    }
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoader) {
            [AlertView dismiss];
        }
        [self dealResult:responseObject showLoader:showLoader showAlert:showAlert succeedBlock:succeedBlock failedBlock:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoader) {
            [AlertView dismiss];
        }
        if ([error.description containsString:@"Error Domain=NSURLErrorDomain"]) {
            failed(@{kMessage:@"似乎已断开与互联网的连接。"});
        }else {
            failed(@{kMessage:error.description});
        }
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)postPayDataWithUrl:(NSString *)url param:(id)params showLoader:(BOOL)showLoader showAlert:(BOOL)showAlert gZip:(BOOL)gZip succeedBlock:(RequestSucceed)succeedBlock failedBlock:(RequestFailed)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([UserStatus shareInstance].isLogin) {
        [manager.requestSerializer setValue:[UserStatus shareInstance].sid forHTTPHeaderField:@"Authorization"];
    }else {
//        [manager.requestSerializer setValue:AuthFlag forHTTPHeaderField:@"Agent-AppAuth"];
    }
    NSURLSessionDataTask *dataTask =  [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResult:responseObject showLoader:showLoader showAlert:showAlert succeedBlock:succeedBlock failedBlock:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        if (failed) {
            failed(@{kMessage:error.description});
        }
    }];
    return dataTask;
}

+ (NSURLSessionDataTask *)getDataWithUrl:(NSString *)url param:(NSDictionary *)params showLoader:(BOOL)showLoader showAlert:(BOOL)showAlert gZip:(BOOL)gZip succeedBlock:(RequestSucceed)succeedBlock failedBlock:(RequestFailed)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([UserStatus shareInstance].isLogin) {
        [manager.requestSerializer setValue:[UserStatus shareInstance].sid forHTTPHeaderField:@"Authorization"];
    }else {
//        [manager.requestSerializer setValue:AuthFlag forHTTPHeaderField:@"Agent-AppAuth"];
    }
    if (showLoader) {
        [AlertView showProgress];
    }
    NSURLSessionDataTask *dataTask =  [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoader) {
            [AlertView dismiss];
        }
        [self dealGetResult:responseObject showLoader:showLoader showAlert:showAlert succeedBlock:succeedBlock failedBlock:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoader) {
            [AlertView dismiss];
        }
        NSLog(@"%@",error.description);
        failed(@{kMessage:error.description});
    }];
    return dataTask;
}

+ (void)dealGetResult:(id)result showLoader:(BOOL)showLoader showAlert:(BOOL)showAlert succeedBlock:(RequestSucceed)succeedBlock failedBlock:(RequestFailed)failed{
    __autoreleasing NSError *error;
    id resultObj = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:&error];
    if (error) {
        return;
    }
    succeedBlock(resultObj);
}

+ (void)dealResult:(id)result showLoader:(BOOL)showLoader showAlert:(BOOL)showAlert succeedBlock:(RequestSucceed)succeedBlock failedBlock:(RequestFailed)failed {
    __autoreleasing NSError *error;
//    id resultObj = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:&error];
    if (error) {
        return;
    }
    
    NSDictionary *statusDict = [result objectForKey:kStatus];
    if ([[statusDict objectForKey:kSucceed] boolValue]) {
        succeedBlock(result);
    }else {
        NSString *message = [statusDict objectForKey:@"error_desc"];
        if (!StringIsNull(message) &&[message containsString:@"验证失效，请重新登陆"]) {
            [[UserStatus shareInstance] destoryUserStatus];
        }
        if (failed) {
            failed(@{kMessage:message});
        }
    }
}

@end

@implementation NSDictionary (NetworkModel)

- (NSString *)message {
    return [self objectForKey:@"msg"];
}

- (BOOL)status {
    if ([[self objectForKey:@"code"] integerValue] ==  -1) {
        return true;
    }
    return false;
}

- (NSDictionary *)data {
    return [self objectForKey:@"data"];
}


@end
