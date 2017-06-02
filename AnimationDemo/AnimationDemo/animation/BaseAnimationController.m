//
//  BaseAnimationController.m
//  AnimationDemo
//
//  Created by tianmaotao on 2017/5/31.
//  Copyright © 2017年 tianmaotao. All rights reserved.
//

#import "BaseAnimationController.h"

#define BUTTON_INTERVAL 15

@interface BaseAnimationController () {
    CALayer *testLayer;
}

@end

@implementation BaseAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
  NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"位移", @"缩放", @"旋转_X", @"旋转_Y", @"旋转_Z", @"bounds", @"返回", nil];
    [self createButtonWithTitles:buttonTitles];
    
    [self createLayer];
    
    // Do any additional setup after loading the view.
}

- (void)createLayer {
    testLayer = [CALayer layer];
     CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    testLayer.cornerRadius = 10;
    testLayer.frame = CGRectMake((screenWidth - 100) / 2, 50, 100, 100);
    testLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lufei"]].CGColor;
    [self.view.layer addSublayer:testLayer];
}

- (void)createButtonWithTitles:(NSArray *)titles {
    if (titles.count == 0) {
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
            [self translation];
            break;
        case 101:
            [self zoom];
            break;
        case 102:
            [self rotate_x];
            break;
        case 103:
            [self rotate_y];
            break;
        case 104:
            [self rotate_z];
            break;
        case 105:
            [self bounds];
            break;
        case 106:
            [self back];
            break;
        default:
            break;
    }
}

/*
 keyPath：可以指定keyPath为CALayer的属性值，并对它的值进行修改，以达到对应的动画效果，需要注意的是部分属性值是不支持动画效果的。
 以下是具有动画效果的keyPath：
 //CATransform3D Key Paths : (example)transform.rotation.z
 //rotation.x
 //rotation.y
 //rotation.z
 //rotation 旋轉
 //scale.x
 //scale.y
 //scale.z
 //scale 缩放
 //translation.x
 //translation.y
 //translation.z
 //translation 平移
 
 //CGPoint Key Paths : (example)position.x
 //x
 //y
 
 //CGRect Key Paths : (example)bounds.size.width
 //origin.x
 //origin.y
 //origin
 //size.width
 //size.height
 //size
 
 //opacity
 //backgroundColor
 //cornerRadius
 //borderWidth
 //contents
 
 //Shadow Key Path:
 //shadowColor
 //shadowOffset
 //shadowOpacity
 //shadowRadius
 
 duration：动画的持续时间
 repeatCount：动画的重复次数
 timingFunction：动画的时间节奏控制
 timingFunctionName的enum值如下：
    kCAMediaTimingFunctionLinear 匀速
    kCAMediaTimingFunctionEaseIn 慢进
    kCAMediaTimingFunctionEaseOut 慢出
    kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
    kCAMediaTimingFunctionDefault 默认值（慢进慢出）
 
 fillMode：视图在非Active时的行为
 removedOnCompletion：动画执行完毕后是否从图层上移除，默认为YES（视图会恢复到动画前的状态），可设置为NO（图层保持动画执行后的状态，前提是fillMode设置为kCAFillModeForwards）
 */

//@"位移"
- (void)translation {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.toValue = [NSValue valueWithCGPoint:self.view.center];
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeBackwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [testLayer addAnimation:animation forKey:@"translation"];
}

//@"缩放"
- (void)zoom {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @2;
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeBackwards;
    
    [testLayer addAnimation:animation forKey:@"zoom"];
}

//@"bounds"
- (void)bounds {
    CABasicAnimation *boundX = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundX.toValue = [NSValue valueWithCGRect:CGRectMake(10,10,200,200)];
    boundX.fillMode = kCAFillModeForwards;
    boundX.duration = 2;

    [testLayer addAnimation:boundX forKey:@"boundsXAni"];
}

//@"旋转_X"
- (void)rotate_x {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.x";
    animation.toValue = @(3.0);
    animation.repeatCount = 1;
    animation.duration = 2;
    
    [testLayer addAnimation:animation forKey:@"boundsXAniation"];
}

//@"旋转_Y"
- (void)rotate_y {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(3.0);
    animation.repeatCount = 1;
    animation.duration = 2;
    
    [testLayer addAnimation:animation forKey:@"boundsYAniation"];
}

//@"旋转_Z"
- (void)rotate_z {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = @(3.0);
    animation.repeatCount = 1;
    animation.duration = 2;
    
    [testLayer addAnimation:animation forKey:@"boundsZAniation"];
}

//返回
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
