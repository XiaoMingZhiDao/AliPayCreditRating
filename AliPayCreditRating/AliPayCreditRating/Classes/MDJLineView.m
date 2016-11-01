//
//  MDJLineView.m
//  MDJDemon
//
//  Created by MDJ on 16/8/12.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "MDJLineView.h"

@interface MDJLineView ()
/** 标记线 */
@property (nonatomic ,weak) UILabel *line ;

/** 文字 */
@property (nonatomic ,weak) UILabel *lineLabel ;

@end


@implementation MDJLineView
-(UILabel *)line
{
    if (!_line) {
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ThemeLineColor;
        [self addSubview:line];
        self.line = line;
    }
    return _line;
}

- (UILabel *)lineLabel
{
    if(!_lineLabel){
        UILabel *label = [[UILabel alloc] init];
        label.textColor = ThemeLineColor;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.lineLabel = label;
    }
    return _lineLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 锚点
        self.layer.anchorPoint = CGPointMake(0.5, 0);

    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.lineLabel.text = name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    
    // line
    CGFloat lineW = 4;
    CGFloat lineH = 8;
    CGFloat lineX = (W - lineW) * 0.5;
    CGFloat lineY = 0;
    self.line.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    // lineLabel
    CGFloat labelW = W;
    CGFloat labelH = H - 10;
    CGFloat labelX = (W - labelW) * 0.5;
    CGFloat labelY = H - labelH ;
    self.lineLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);

}

@end
