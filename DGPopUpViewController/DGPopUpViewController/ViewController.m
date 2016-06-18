//
//  ViewController.m
//  DGPopUpViewController
//
//  Created by 段昊宇 on 16/6/17.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "DGPopUpViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *popUpButton;
@property (strong, nonatomic) DGPopUpViewController *popUpViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)clickButton:(id)sender {
    
    self.popUpViewController = [[DGPopUpViewController alloc] init];
    [self.popUpViewController showInView: self.view animated: YES];
}

@end
