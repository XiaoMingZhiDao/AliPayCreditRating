//
//  MDJLineView.h
//  MDJDemon
//
//  Created by MDJ on 16/8/12.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

// 主题色
#define ThemeLineColor [UIColor colorWithRed:0.75f green:0.62f blue:0.31f alpha:1.00f]
// 背景色
#define ThemeBgColor [UIColor colorWithRed:0.21f green:0.21f blue:0.21f alpha:1.00f]
// 角度转换
#define angle2radian(x) ((x) / 180.0 * M_PI)

@interface MDJLineView : UIView

@property (nonatomic ,copy) NSString *name;

@end
