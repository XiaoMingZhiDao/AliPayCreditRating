//
//  MDJProgressChat.m
//  MDJDemon
//
//  Created by MDJ on 16/8/11.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "MDJProgressChat.h"
#import "MDJLineView.h"


// 分数字号
static const CGFloat scoreFont = 62 ;
// 标题字号
static const CGFloat nameFont = 22 ;
// 时间字号
static const CGFloat timeFont = 18 ;

// 分割线宽
static const NSInteger lineW = 40;
// 分割线高
static const NSInteger lineH = 30;

// 圆弧半径
static const CGFloat Radius = 100;
// 圆弧线宽
static const CGFloat arcW = 5;
// 圆弧开始角度
static const CGFloat ArcStartA = M_PI_4*3;
// 圆弧结束角度
static const CGFloat ArcEndA = M_PI_4 + M_PI *2;



@interface MDJProgressChat ()

/** 分数栏 */
@property (nonatomic ,weak) UILabel *scoreLabel ;

/** 测一测 */
@property (nonatomic ,weak) UILabel *nameLabel ;

/** 时间 */
@property (nonatomic ,weak) UILabel *timeLabel ;

/** 圆弧中点 */
@property (nonatomic ,assign) CGPoint ArcCenter;

/** 动画图层 */
@property (nonatomic, strong) CAShapeLayer *loadingLayer;

/** 定时器 */
@property (nonatomic ,strong) NSTimer *timer ;

@end

@implementation MDJProgressChat
#pragma mark - 懒加载
- (NSTimer *)timer
{
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        self.timer = timer;
    }
    return _timer;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = ThemeLineColor;
        timeLabel.text = @"2016-08-11 15:49";
        timeLabel.font = [UIFont systemFontOfSize:timeFont];
        [self addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = ThemeLineColor;
        nameLabel.text = @"测一测";
        nameLabel.font = [UIFont systemFontOfSize:nameFont];
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

- (UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.font = [UIFont systemFontOfSize:nameFont];
        scoreLabel.textColor = ThemeLineColor;
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.attributedText = [self attribbuteFromeString:@"0分"];
        [self addSubview:scoreLabel];
        self.scoreLabel = scoreLabel;
    }
    return _scoreLabel;
}

- (CAShapeLayer *)loadingLayer
{
    if (!_loadingLayer) {
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        
        // 指定frame，只是为了设置宽度和高度
        circleLayer.frame = self.bounds;
        // 设置线宽
        circleLayer.lineWidth = arcW;
        // 设置线的颜色
        circleLayer.strokeColor = [UIColor clearColor].CGColor;
        // 设置填充色
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeEnd = 0;
        
        // 使用UIBezierPath创建路径
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.ArcCenter radius:Radius startAngle:ArcStartA endAngle:ArcEndA clockwise:YES];
        
        // 设置CAShapeLayer与UIBezierPath关联
        circleLayer.path = circlePath.CGPath;
        circleLayer.lineCap = @"round";
        
        // 将CAShaperLayer放到某个层上显示
        [self.layer addSublayer:circleLayer];
        _loadingLayer = circleLayer;
    }
    return _loadingLayer;
}

#pragma mark - 工具
// 富文本
- (NSMutableAttributedString *)attribbuteFromeString:(NSString *)text {
    // 1.
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSAttributedString *substr = nil;
    substr = [[NSAttributedString alloc] initWithString:text];
    [attributedText appendAttributedString:substr];
    
    UIFont *font = [UIFont boldSystemFontOfSize:scoreFont];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 };
    [attributedText addAttributes:attributes range:NSMakeRange(0, attributedText.length-1)];
    return attributedText;
}

- (CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW andText:(NSString *)text
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 初始化
+ (instancetype)sharedProgressChatWithFrame:(CGRect)frame andNames:(nonnull NSArray<NSString *> *)names andEndValue:(CGFloat)endValue
{
    return [[self alloc] initWithFrame:frame andNames:names andEndValue:endValue];
}

- (instancetype)initWithFrame:(CGRect)frame andNames:(NSArray <NSString *>*)names andEndValue:(CGFloat)endValue
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景色
        self.backgroundColor = ThemeBgColor;
        self.endValue = endValue;
        
        // 原点坐标
        CGFloat topMargin = 20;
        CGFloat centerX = self.center.x;
        CGFloat centerY = Radius + topMargin;
        CGPoint center = CGPointMake(centerX,centerY);
        self.ArcCenter = center;
        
        // 分割线
        CGFloat perAngle = ((ArcEndA- ArcStartA) /(1 + names.count));
        for (int i = 0; i < names.count; i++) {
            // 创建控件
            MDJLineView *lineView = [[MDJLineView alloc] init];
            lineView.name = names[i];
            
            // 旋转控件
            CGFloat angle = M_PI_4 + perAngle * (i+1);
            CGFloat newX = self.ArcCenter.x - (-arcW*0.5 + Radius) * sin(angle) ;
            CGFloat newY = self.ArcCenter.y + (-arcW*0.5 + Radius) * cos(angle) ;
            
            // 位置
            lineView.layer.position = CGPointMake(newX, newY);
            
            // 尺寸
            lineView.bounds = CGRectMake(0, 0, lineW, lineH);
            lineView.layer.transform = CATransform3DMakeRotation(angle - M_PI, 0, 0, 1);
            
            [self addSubview:lineView];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 背景弧线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.ArcCenter radius:Radius startAngle:ArcStartA endAngle:ArcEndA clockwise:YES];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, arcW);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // scoreLabel
    CGSize textSize = [self sizeWithfont:self.scoreLabel.font maxW:CGRectGetWidth(self.frame) andText:self.scoreLabel.text];
    self.scoreLabel.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    
    // nameLabel
    CGSize nameLabelSzie = [self sizeWithfont:self.nameLabel.font maxW:CGRectGetWidth(self.frame) andText:self.nameLabel.text];
    self.nameLabel.bounds = CGRectMake(0, 0, nameLabelSzie.width, nameLabelSzie.height);
    
    // timeLabel
    CGSize timeLabelSzie = [self sizeWithfont:self.timeLabel.font maxW:CGRectGetWidth(self.frame) andText:self.timeLabel.text];
    self.timeLabel.bounds = CGRectMake(0, 0, timeLabelSzie.width, timeLabelSzie.height);
    
    // scoreLabel、nameLabel、timeLabel
    self.scoreLabel.center = CGPointMake(self.center.x, Radius + 20);
    self.nameLabel.center = CGPointMake(self.center.x, 2*Radius + 10) ;
    self.timeLabel.center = CGPointMake(self.center.x, 2*Radius+50);
    
    [self timer];
}

- (void)updateProgress
{
    self.loadingLayer.strokeEnd += 0.01;
    self.loadingLayer.strokeColor = ThemeLineColor.CGColor;
    
    if (self.loadingLayer.strokeEnd >= self.endValue) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - setter
- (void)setTime:(NSString *)time
{
    _time = time;
    
    self.timeLabel.text = time;
    
    [self setNeedsDisplay];

    [self.timeLabel sizeToFit];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
    
    [self setNeedsDisplay];
    
    [self.timeLabel sizeToFit];
}

- (void)setEndValue:(CGFloat)endValue
{
    _endValue = endValue;
    
    
    self.scoreLabel.attributedText = [self attribbuteFromeString:[NSString stringWithFormat:@"%.f分",endValue*100]];
    
    [self setNeedsDisplay];

    [self.scoreLabel sizeToFit];
}

@end
