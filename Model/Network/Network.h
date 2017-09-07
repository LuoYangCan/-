//
//  Network.h
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/7.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject

+(Network *)sharedNetworking;








-(void)RequestwithData:(NSDictionary *)data andURLparameters:(NSString *)parameters Completion:(void (^)( NSError * , id , NSURLSessionTask * ))block;



@end
