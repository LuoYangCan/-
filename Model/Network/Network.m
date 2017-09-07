//
//  Network.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/7.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "Network.h"
#import <AFNetworking.h>
static Network *_sharedNetworking = nil;
static NSString * const BaseURL = @"";
@implementation Network

+(Network *)sharedNetworking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetworking = [[Network alloc]init];
    });
    return _sharedNetworking;
}





-(void)RequestwithData:(NSDictionary *)data andURLparameters:(NSString *)parameters Completion:(void (^)( NSError * , id , NSURLSessionTask * ))block{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager GET:BaseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(nil, responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(error, nil, task);
        }
    }];
}


@end
