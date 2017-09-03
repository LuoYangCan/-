//
//  SearchTableViewCell.m
//  国际礼仪应对系统
//
//  Created by 孤岛 on 2017/9/4.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "SearchTableViewCell.h"
#import <Masonry.h>
@implementation SearchTableViewCell

-(instancetype)initWithArray:(NSArray *)array andRow:(NSIndexPath *)indexPath{
    if (self = [super init]) {
        NSDictionary *dic = array[indexPath.row];
        UILabel *labl = [[UILabel alloc]init];
        labl.text =dic[@"title"];
        [self addSubview:labl];
        [labl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(20);
            make.top.equalTo(self).mas_offset(10);
            make.bottom.equalTo(self).mas_offset(-10);
        }];
    }
    return self;

}
@end
