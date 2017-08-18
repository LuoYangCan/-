//
//  Tool.m
//  InternationalEtiquette
//
//  Created by 孤岛 on 2017/8/18.
//  Copyright © 2017年 孤岛. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Tool.h"

@implementation Tool


+ (UIColor *)getColor:(NSString *)hexColor{
    if (![hexColor isEqualToString:@""]||![[hexColor substringToIndex:1] isEqualToString:@"#"]||(hexColor.length!=7&&hexColor.length!=9)) {
        return [UIColor blackColor];
    }
    unsigned int red,green,blue,alpha=255;
    NSInteger index=1;
    NSRange range;
    range.length = 2;
    
    if (hexColor.length==9) {
        range.location =index;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
        index+=2;
    }
    
    range.location =index;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location =index+2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location =index+4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:(float)(alpha/ 255.0f)];
}


+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
