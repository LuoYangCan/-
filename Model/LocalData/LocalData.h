//
//  LocalData.h
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/25.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject
+ (LocalData *)getInstance;

-(void)getArticalwithContent_id:(NSString *)Content_id completion:(void (^) (id responseArray, NSError * error))block;

-(void)getDataArrayWithcompletion:(void(^) (NSArray * responseArray))completionblock;


-(void)getSearchMessagewithArray:(NSMutableArray *)searchArray Searchstr:(NSString *)searchStr completion:(void (^) (NSError * error , id responseArray))block;
@end
