//
//  DGPopUpViewController.m
//  DGPopUpViewController
//
//  Created by 段昊宇 on 16/6/17.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DGPopUpViewController.h"
#import "DGPopUpView.h"

@interface DGPopUpViewController () {
    BOOL isOpen;
}

@property (nonatomic, strong) DGPopUpView *popUpView;
@property (nonatomic, strong) UIButton *popUpCloseButton;
@property (nonatomic, strong) UIImageView *endView;

@end

@implementation DGPopUpViewController

#pragma mark - Overrite
- (instancetype) init {
    isOpen = YES;
    self.view.backgroundColor = DGPopUpViewBackgroundColor;
    
    [self.view addSubview: self.popUpCloseButton];
    [self.view addSubview: self.popUpView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(endAnimation)
                                                 name: @"end_animation"
                                               object: nil];
    // [self endAnimation];
    return self;
}

#pragma mark - Life Cycle
- (void) viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Add SubView
- (void) showInView: (UIView *)aView animated: (BOOL)animated {
    self.view.center = aView.center;
    [aView addSubview: self.view];
    if (animated) {
        [self showAnimation];
    }
}

#pragma mark - Removew SubView
- (void) removeAnimation {
    self.popUpView.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration: 0.6
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.popUpView.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         [self.view removeFromSuperview];
                     }];
}

- (void) endAnimation {
    self.endView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"end_logo"]];
    self.endView.center = self.view.center;
    [self.view addSubview: self.endView];
    
    
    self.endView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration: 1.4
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         self.endView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                     }
                     completion: ^(BOOL finished) {
                         
                     }];
}

#pragma mark - Animation
- (void) showAnimation {
    self.view.alpha = 0.0;
    self.popUpView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration: 0.25
                     animations: ^{
                         self.view.alpha = 1.0;
                     }
                     completion: ^(BOOL finished) {
                         [self showPopUpView];
                     }];
}

- (void) showPopUpView {
    self.popUpView.alpha = 0.5;
    [UIView animateWithDuration: 0.8
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         self.popUpView.transform = CGAffineTransformMakeScale(1, 1);
                         self.popUpView.alpha = 1;
                     }
                     completion: ^(BOOL finished) {
                         
                     }];
}

#pragma mark - Lazy Init
- (UIButton *) popUpCloseButton {
    if (!_popUpCloseButton) {
        _popUpCloseButton = [[UIButton alloc] initWithFrame: self.view.bounds];
        _popUpCloseButton.backgroundColor = [UIColor clearColor];
        [_popUpCloseButton setTitle: @"" forState: UIControlStateNormal];
        [_popUpCloseButton addTarget: self
                              action: @selector(removeAnimation)
                    forControlEvents: UIControlEventTouchUpInside];
    }
    return _popUpCloseButton;
}

- (DGPopUpView *) popUpView {
    if (!_popUpView) {
        _popUpView = [[DGPopUpView alloc] init];
        _popUpView.center = self.view.center;
    }
    return _popUpView;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
