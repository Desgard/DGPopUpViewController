//
//  DGPopUpViewTextView.m
//  DGPopUpViewController
//
//  Created by 段昊宇 on 16/6/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DGPopUpViewTextView.h"

@interface DGPopUpViewTextView()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *progressLine;

@end

@implementation DGPopUpViewTextView

- (instancetype) initWithName: (NSString *) name {
    if (self  = [super init]) {
        NSString * className = NSStringFromClass([self class]);
        self.mainView = [[[NSBundle mainBundle] loadNibNamed: className
                                                       owner: self
                                                     options: nil] firstObject];
        [self setTextFieldProperty: name];
        [self setUserInteractionEnabled: YES];
        [self addSubview: self.mainView];
    }
    return self;
}

- (instancetype) init {
    self = [self initWithName: @""];
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self  = [super initWithCoder: aDecoder]) {
        NSString * className = NSStringFromClass([self class]);
        self.mainView = [[[NSBundle mainBundle] loadNibNamed: className
                                                       owner: self
                                                     options: nil] firstObject];
        
        [self setTextFieldProperty: @""];
        [self addSubview: self.mainView];
    }
    return self;
}

- (void) setTextFieldProperty: (NSString *) name {
    self.textField.delegate = self;
    self.textField.placeholder = name;
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing: (UITextField *)textField {
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath: @"transform.scale.x"];
    [self.progressLine.layer setAnchorPoint: CGPointMake(0, 0.5)];
    basic.duration = 0.3;
    basic.repeatCount = 1;
    basic.removedOnCompletion = NO;
    basic.fromValue = [NSNumber numberWithFloat: 1];
    basic.toValue = [NSNumber numberWithFloat: 280];
    basic.fillMode = kCAFillModeForwards;
    basic.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    [self.progressLine.layer addAnimation: basic forKey: nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.textField.text isEqualToString: @""]) {
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath: @"transform.scale.x"];
        [self.progressLine.layer setAnchorPoint: CGPointMake(0, 0.5)];
        basic.duration = 0.3;
        basic.repeatCount = 1;
        basic.removedOnCompletion = NO;
        basic.fromValue = [NSNumber numberWithFloat: 280];
        basic.toValue = [NSNumber numberWithFloat: 1];
        basic.fillMode = kCAFillModeForwards;
        basic.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        [self.progressLine.layer addAnimation: basic forKey: nil];
    }
    
}

@end
