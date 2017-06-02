//
//  ViewController.m
//  AnimationDemo
//
//  Created by tianmaotao on 2017/5/31.
//  Copyright © 2017年 tianmaotao. All rights reserved.
//

#import "ViewController.h"
#import "BaseAnimationController.h"
#import "KeyframeAnimationController.h"
#import "TransitionAnimationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)baseAnimationAction:(id)sender {
     BaseAnimationController *baseAnimationController = [[BaseAnimationController alloc] init];
    [self presentViewController:baseAnimationController animated:YES completion:nil];
}

- (IBAction)keyframeAnimationAction:(id)sender {
    KeyframeAnimationController *keyframeAnimationController = [[KeyframeAnimationController alloc] init];
     [self presentViewController:keyframeAnimationController animated:YES completion:nil];
}
- (IBAction)transitionAnimation:(id)sender {
    TransitionAnimationController *transitionAnimationController = [[TransitionAnimationController alloc] init];
    [self presentViewController:transitionAnimationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
