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
@implementation Network

+(Network *)sharedNetworking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetworking = [[Network alloc]init];
    });
    return _sharedNetworking;
}








@end
