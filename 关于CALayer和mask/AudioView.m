//
//  AudioView.m
//  关于CALayer和mask
//
//  Created by th on 2018/7/29.
//  Copyright © 2018年 huant. All rights reserved.
//

#import "AudioView.h"

static const CGFloat lineWith = 15.f;
static const CGFloat lineMargin = 5.f;

@interface AudioView()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer * bgLayer;

@property (nonatomic, strong) CAShapeLayer * redLayer;

@property (nonatomic, strong) CAShapeLayer * maskLayer;

@end

@implementation AudioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUIs];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initUIs];

    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initUIs];

}
- (void)initUIs{
    [self.layer addSublayer:self.bgLayer];
    [self.layer addSublayer:self.redLayer];
    self.redLayer.mask = self.maskLayer;
}


/**
 开始绘制layer, bezierPath告诉layer怎么绘制
 */
- (void)layOutLayers{
    
    CGFloat maxWith = self.frame.size.width;
    
    UIBezierPath * path = [UIBezierPath new];
    CGFloat totalWith = 0;
    while (totalWith < maxWith) {
        
        [path moveToPoint:CGPointMake(totalWith+lineMargin, 10)];
        [path addLineToPoint:CGPointMake(totalWith+lineMargin, self.frame.size.height-20)];
        
        totalWith += lineMargin + lineWith;
    }
 

    self.bgLayer.path = path.CGPath;
    self.redLayer.path = path.CGPath;
}

- (void)updatePercent:(CGFloat)percent{
    self.maskLayer.strokeEnd = 0.5;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:percent];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self;
    [self.maskLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}


/**
 初始化layer，设置线宽  颜色之类的

 @return .
 */
- (CAShapeLayer *)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer new];
        _bgLayer.lineWidth = lineWith;
        _bgLayer.strokeColor = [UIColor grayColor].CGColor;
        _bgLayer.lineCap = kCALineCapRound;

    }
    return _bgLayer;
}

- (CAShapeLayer *)redLayer{
    if (!_redLayer) {
        _redLayer = [CAShapeLayer new];
        _redLayer.lineWidth = lineWith;
        _redLayer.strokeColor = [UIColor redColor].CGColor;
        _redLayer.lineCap = kCALineCapRound;
    }
    return _redLayer;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer new];
        _maskLayer.strokeColor = [UIColor blueColor].CGColor;// 这里必须设置颜色，否则mask没有效果
        UIBezierPath * path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        _maskLayer.lineWidth = self.frame.size.height;
        _maskLayer.path = path.CGPath;
        
    }
    return _maskLayer;
}
@end
