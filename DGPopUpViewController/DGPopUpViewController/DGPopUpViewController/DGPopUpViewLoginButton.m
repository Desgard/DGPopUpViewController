//
//  DGPopUpViewLoginButton.m
//  DGPopUpViewController
//
//  Created by 段昊宇 on 16/6/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DGPopUpViewLoginButton.h"

@implementation DGPopUpViewLoginButton

- (instancetype) initWithFrame: (CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        // 设置样式颜色
        [self setColor];
        
        // 设置title
        [self setTitle: @"NEXT" forState: UIControlStateNormal];
        
        [self addTarget: self
                 action: @selector(pressAnimation)
       forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype) init {
    self = [self initWithFrame: CGRectMake(0, 0, 320, 60)];
    return self;
}

#pragma mark - Set Color
- (void) setColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.locations = @[@0.3, @0.8];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed: 56 / 255.f green: 195 / 255.f blue: 227 / 255.f alpha: 1].CGColor,
                             (__bridge id)[UIColor colorWithRed: 16 / 255.f green: 156 / 255.f blue: 197 / 255.f alpha: 1].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    [self.layer addSublayer: gradientLayer];
}

#pragma mark - Animation
- (void) pressAnimation {
    NSLog(@"click");
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration: 0.6
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                     }
                     completion: ^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"NEXT_Button" object: nil];
}

@end
