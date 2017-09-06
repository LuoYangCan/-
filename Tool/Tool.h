//
//  Tool.h
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/18.
//  Copyright © 2017年 孤岛. All rights reserved.
//

#import <Foundation/Foundation.h>


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





/**
 设置搜索框内部颜色
 */
+(void)setSearchBar:(UISearchBar *)searchBar InsideBackgroundColor:(UIColor *)backgroudColor;

@end






#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])






#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

