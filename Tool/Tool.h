//
//  Tool.h
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/18.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
@interface Tool : NSObject


/**
 将搜索栏透明
 */
//+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
+(void)getClearSearchBar:(UISearchBar *)searchBar;






/**
 切圆角工具
 */
+(UIView *)getCycleView:(UIView *)View WithRect:(CGRect)rect;






/**
   hexColor获取
 */
+ (UIColor *)getColor:(NSString *)hexColor;

@end
