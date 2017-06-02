//
//  TransitionAnimationController.m
//  AnimationDemo
//
//  Created by tianmaotao on 2017/6/1.
//  Copyright © 2017年 tianmaotao. All rights reserved.
//

#import "TransitionAnimationController.h"
#define BUTTON_INTERVAL 15

@interface TransitionAnimationController () {
     CALayer *testLayer;
}

@end

@implementation TransitionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createLayer];
    
    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"渐变", @"覆盖", @"推开", @"揭开", @"弹变", @"旋转", @"翻页", @"扯开", @"返回",  nil];
    
    [self createButtonWithTitles:buttonTitles];

    // Do any additional setup after loading the view.
}

- (void)createLayer {
    testLayer = [CALayer layer];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    testLayer.frame = CGRectMake((screenWidth - 200) / 2, 200, 200, 200);
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lufei"]].CGColor;
    testLayer.cornerRadius = 10;
    
    [self.view.layer addSublayer:testLayer];
}

- (void)createButtonWithTitles:(NSArray *)titles {
    if (!titles || titles.count == 0) {
        return;
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSInteger count = titles.count;
    
    NSInteger index_x = 0;
    NSInteger index_y = 0;
    CGFloat startHeith = screenHeight - 200;
    CGFloat buttonWith = (screenWidth - 5 * BUTTON_INTERVAL) / 4;
    CGFloat buttonHeight = 50;
    
    for (int i = 0; i < count; i++) {
        
        if (index_x >= 4) {
            index_x = 0;
            index_y++;
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(index_x * buttonWith + (index_x + 1) * BUTTON_INTERVAL, startHeith + index_y * 55, buttonWith, buttonHeight)];
        btn.backgroundColor = [UIColor purpleColor];
        btn.tag = 100 + i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        index_x++;
    }
}

- (void)action:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
    
    NSInteger tag = sender.tag;
    switch (tag) {
        case 100:
            [self transitionFade];
            break;
        case 101:
            [self transitionMoveIn];
            break;
        case 102:
            [self transitionPush];
            break;
        case 103:
            [self transitionReveal];
            break;
        case 104:
            [self transitionRippleEffect];
            break;
        case 105:
            [self transitionCube];
            break;
        case 106:
            [self transitionPageCurl];
            break;
        case 107:
            [self transitionSuckEffect];
            break;
        case 108:
            [self back];
            break;
        
        default:
            break;
    }
}

//渐变
- (void)transitionFade {
    CATransition *animation = [CATransition animation];
    /**
     * type的enum值如下：
     * kCATransitionFade   渐变
     * kCATransitionMoveIn 覆盖
     * kCATransitionPush   推出
     * kCATransitionReveal 揭开
     */
    animation.type = kCATransitionFade;
    
    /**
     * subtype的enum值如下：
     * kCATransitionFromRight      从右边
     * kCATransitionFromLeft       从左边
     * kCATransitionFromTop        从顶部
     * kCATransitionFromBottom     从底部
     */
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qiaoba"]].CGColor;
    [testLayer addAnimation:animation forKey:@"transitionFade"];
}

//覆盖
- (void)transitionMoveIn {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qiaoba"]].CGColor;
    [testLayer addAnimation:animation forKey:@"transitionFade"];
}

//推开
- (void)transitionPush {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"namei"]].CGColor;
    [testLayer addAnimation:animation forKey:@"transitionFade"];
}

//揭开
- (void)transitionReveal {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"suolong"]].CGColor;
    [testLayer addAnimation:animation forKey:@"transitionFade"];
}

#pragma 以下是部分私有转场动画效果
//弹变
- (void)transitionRippleEffect {
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"namei"]].CGColor;
    [testLayer addAnimation:animation forKey:@"rippleEffect"];
}

//旋转
- (void)transitionCube {
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qiaoba"]].CGColor;
    [testLayer addAnimation:animation forKey:@"cube"];
}

//翻页
- (void)transitionPageCurl {
    CATransition *animation = [CATransition animation];
    animation.type = @"pageUnCurl";
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lufei"]].CGColor;
    [testLayer addAnimation:animation forKey:@"pageUnCurl"];
}

//扯开
- (void)transitionSuckEffect {
    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 2.0;
    
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"suolong"]].CGColor;
    [testLayer addAnimation:animation forKey:@"suckEffect"];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
