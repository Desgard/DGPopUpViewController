//
//  DGPopUpView.m
//  DGPopUpViewController
//
//  Created by 段昊宇 on 16/6/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DGPopUpView.h"
#import "DGPopUpViewLoginButton.h"
#import "DGPopUpViewTextView.h"

#import "Masonry.h"

@interface DGPopUpView()

@property (nonatomic, strong) UILabel *popViewTitle;
@property (nonatomic, strong) DGPopUpViewLoginButton *loginButton;
@property (nonatomic, strong) DGPopUpViewTextView *textView;
@property (nonatomic, strong) DGPopUpViewTextView *textView_2;
@property (nonatomic, strong) DGPopUpViewTextView *textView_3;

@end

@implementation DGPopUpView

#pragma mark - Overide
- (instancetype) initWithFrame: (CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.shadowOpacity = 0.4;
        self.layer.shadowOffset = CGSizeMake(0.2, 0.2);
        
        self.loginButton = [[DGPopUpViewLoginButton alloc] init];
        [self addSubview: self.loginButton];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(closeAnimation)
                                                     name: @"NEXT_Button"
                                                   object: nil];
        
        self.textView = [[DGPopUpViewTextView alloc] initWithName: @"First name"];
        self.textView_2 = [[DGPopUpViewTextView alloc] initWithName: @"Last name"];
        self.textView_3 = [[DGPopUpViewTextView alloc] initWithName: @"Email"];
        [self addSubview: self.textView];
        [self addSubview: self.textView_2];
        [self addSubview: self.textView_3];
        
        self.popViewTitle = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 320, 40)];
        self.popViewTitle.text = @"SIGN UP";
        self.popViewTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.popViewTitle];
        
        [self setlayout];
    }
    return self;
}

- (instancetype) init {
    self = [self initWithFrame: CGRectMake(0, 0, 320, 480)];
    return self;
}

#pragma mark - Layout
- (void) setlayout {
    self.loginButton.frame = CGRectMake(0, self.frame.size.height - self.loginButton.frame.size.height, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
    
    self.textView.frame = CGRectMake(0, 80, 320, 60);
    self.textView_2.frame = CGRectMake(0, 160, 320, 60);
    self.textView_3.frame = CGRectMake(0, 240, 320, 60);
}

#pragma mark - Close Animation
- (void) closeAnimation {
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration: 0.6
                          delay: 0.3
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         self.superview.alpha = 1;
                     }
                     completion: ^(BOOL finished) {
                         [[NSNotificationCenter defaultCenter] postNotificationName: @"end_animation" object: nil];
                         [self removeFromSuperview];
                     }];
    
}

@end
