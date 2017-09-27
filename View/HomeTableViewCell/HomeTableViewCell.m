//
//  HomeTableViewCell.m
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/19.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Tool.h"
@implementation HomeTableViewCell
{
    NSDictionary * MessageDic;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
    //self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        MessageDic = [NSDictionary dictionaryWithDictionary:dic];
        [self setup];
    }
    return self;
}

-(void)setup{
    UIImageView *leftimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 105 ,90)];
    leftimage.backgroundColor = RGBColor(211, 211, 211, 1);
    [leftimage setImage:[UIImage imageNamed:MessageDic[@"image"]]];
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(128, 46, SCREEN_WIDTH - 165, 60)];
//    content.backgroundColor = [UIColor blackColor];
 //   content.backgroundColor = [UIColor cyanColor];
    content.textAlignment = NSTextAlignmentLeft;
    content.numberOfLines = 3;
    NSString *contentStr = [[NSString alloc]init];
    NSString *str = MessageDic[@"content"];
    if (str.length < 120) {
        contentStr = str;
    }else{
        contentStr = [str substringToIndex:120];
    }
//    content.text = @"这个Cell非常的清真，超级清真，非常的清真，舒服的舒服哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦oooo o o o oooo哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦";
    content.text = contentStr;
    [content setFont:[UIFont systemFontOfSize:13.5]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(127, 20, SCREEN_WIDTH, 20)];
//    title.backgroundColor = [UIColor orangeColor];
   // title.backgroundColor = [UIColor greenColor];
    NSString *titletext = MessageDic[@"title"];
//    title.text = @"这是一个非常清真的标题";
    title.text = titletext;
//    title.font = [UIFont systemFontOfSize:18];
    title.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
    [self addSubview:leftimage];
    [self addSubview:content];
    
}
@end
