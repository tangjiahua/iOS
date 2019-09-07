//
//  LikeButton.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "LikeButton.h"

@interface LikeButton()

@property (nonatomic, strong) CAEmitterLayer * explosionLayer;

@end

@implementation LikeButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupExplosion];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupExplosion];
    }
    return self;
}

- (void)setupExplosion{
    
    // 1. 粒子
    CAEmitterCell * explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosionCell";
    explosionCell.alphaSpeed = -1.f;
    explosionCell.alphaRange = 0.10;
    explosionCell.lifetime = 1;
    explosionCell.lifetimeRange = 0.1;
    explosionCell.velocity = 40.f;
    explosionCell.velocityRange = 10.f;
    explosionCell.scale = 0.08;
    explosionCell.scaleRange = 0.02;
    explosionCell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];
    
    // 2.发射源
    CAEmitterLayer * explosionLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:explosionLayer];
    self.explosionLayer = explosionLayer;
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    explosionLayer.emitterCells = @[explosionCell];
}

-(void)layoutSubviews{
    // 发射源位置
    self.explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    [super layoutSubviews];
}

/**
 * 选中状态 实现缩放
 */
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    // 通过关键帧动画实现缩放
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    if (selected) {  // 从没有点击到点击状态 会有爆炸的动画效果
        animation.values = @[@1.5,@2.0, @0.8, @1.0];
        animation.duration = 0.5;
        
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:nil];
        
        // 让放大动画先执行完毕 再执行爆炸动画
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    }else{ // 从点击状态normal状态 无动画效果 如果点赞之后马上取消 那么也立马停止动画
        [self stopAnimation];
    }
}

// 没有高亮状态
- (void)setHighlighted:(BOOL)highlighted{[super setHighlighted:highlighted];}

/**
 * 开始动画
 */
- (void)startAnimation{
    
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@1000 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    
    // 开始动画
    self.explosionLayer.beginTime = CACurrentMediaTime();
    
    // 延迟停止动画
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

/**
 * 动画结束
 */
- (void)stopAnimation{
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    [self.explosionLayer removeAllAnimations];
}

@end
