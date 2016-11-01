//
//  MDJProgressChat.h
//  MDJDemon
//
//  Created by MDJ on 16/8/11.
//  Copyright © 2016年 MDJ. All rights reserved.

//  例子:
//  CGRect rect = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
//
//  NSArray *names = @[@"良好",@"优秀",@"极好"];
//
//  MDJProgressChat *chat = [MDJProgressChat sharedProgressChatWithFrame:rect andNames:names andEndValue:0.3];
//  [self.view addSubview:chat];

#import <UIKit/UIKit.h>

@interface MDJProgressChat : UIView

/**
 *  初始化
 *
 *  @param frame 尺寸,此frame改变时，注意在MDJProgressChat.m 修改字号
 *  @param names 分割线的名字，如:@[@"优秀,@"良好",...];
 *  @param endValue 分数百分比，0~1:代表弧度的起点~中点，0.5:弧度的中点
 *
 *  @return 初始化控件
 */
+ (nonnull instancetype)sharedProgressChatWithFrame:(CGRect)frame andNames:(nonnull NSArray<NSString *>*)names andEndValue:(CGFloat)endValue;

/** endValue @optional: */
@property (nonatomic ,assign) CGFloat endValue ;

/** name @optional: */
@property (nonatomic ,copy,nullable) NSString *name ;

/** time @optional: */
@property (nonatomic ,copy,nullable) NSString *time ;

@end
