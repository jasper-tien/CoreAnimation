//
//  KeyframeAnimationController.m
//  AnimationDemo
//
//  Created by tianmaotao on 2017/5/31.
//  Copyright © 2017年 tianmaotao. All rights reserved.
//

#import "KeyframeAnimationController.h"
#define BUTTON_INTERVAL 15


@interface KeyframeAnimationController () {
    CALayer *testLayer;
}

@end

@implementation KeyframeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createLayer];

    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"正方形", @"圆形", @"曲线", @"心", @"返回",  nil];
    
    [self createButtonWithTitles:buttonTitles];
    
    // Do any additional setup after loading the view.
}

- (void)createLayer {
    testLayer = [CALayer layer];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    testLayer.frame = CGRectMake((screenWidth - 100) / 2, 50, 100, 100);
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
            [self squarePath];
            break;
        case 101:
            [self circularPath];
            break;
        case 102:
            [self bezierPath];
            break;
        case 103:
            [self heartPath];
            break;
        case 104:
            [self back];
            break;
        case 105:
           
            break;
            
        default:
            break;
    }
}

/**
 *　values：关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间段内，依次执行数组中每一个关键帧的动画。
 *　path：动画路径对象，可以指定一个路径，在执行动画时路径会沿着路径移动，Path在动画中只会影响视图的Position。
 *　keyTimes：设置关键帧对应的时间点，范围：0-1。如果没有设置该属性，则每一帧的时间平分。
 */
//正方形
- (void)squarePath {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    
    keyframeAnimation.duration = 4.0;
    
    keyframeAnimation.fillMode = kCAFillModeBackwards;
    
    keyframeAnimation.repeatCount = 2;
    
    CGPoint position = testLayer.position;
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(position.x, position.y)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(position.x + 100, position.y)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(position.x + 100, position.y + 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(position.x - 100, position.y + 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(position.x - 100, position.y)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(position.x, position.y)];
    keyframeAnimation.values = @[value1, value2, value3, value4,value5, value6];
    
    [testLayer addAnimation:keyframeAnimation forKey:@"squarePath"];
}

//圆
- (void)circularPath {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    keyframeAnimation.duration = 4.0;
    keyframeAnimation.fillMode = kCAFillModeBackwards;
    keyframeAnimation.repeatCount = 2;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint position = testLayer.frame.origin;
    CGPathAddEllipseInRect(path, NULL, CGRectMake(position.x, position.y, 100, 200));
    keyframeAnimation.path = path;
    CGPathRelease(path);
    
    [testLayer addAnimation:keyframeAnimation forKey:@"circularPath"];
}

//贝塞尔曲线
- (void)bezierPath {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    keyframeAnimation.duration = 4.0;
    keyframeAnimation.fillMode = kCAFillModeBackwards;
    keyframeAnimation.repeatCount = 2;
    
    CGPoint point = testLayer.frame.origin;
    CGPoint endPoint = CGPointMake(point.x, point.y + 200);
    CGPoint controlPoint1 = CGPointMake(point.x - 50, point.y + 80);
    CGPoint controlPoint2 = CGPointMake(point.x + 50, point.y + 120);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    keyframeAnimation.path = path.CGPath;
    [testLayer addAnimation:keyframeAnimation forKey:@"bezierPath"];
}

- (void)heartPath {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"position";
    keyframeAnimation.duration = 4.0;
    keyframeAnimation.fillMode = kCAFillModeBackwards;
    keyframeAnimation.repeatCount = 2;
    
    CGRect rect = CGRectMake(0, 0, 400, 300);
    // 初始化UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 首先设置一个起始点
    CGPoint startPoint = CGPointMake(rect.size.width/2, 120);
    // 以起始点为路径的起点
    [path moveToPoint:startPoint];
    // 设置一个终点
    CGPoint endPoint = CGPointMake(rect.size.width/2, rect.size.height-40);
    // 设置第一个控制点
    CGPoint controlPoint1 = CGPointMake(100, 20);
    // 设置第二个控制点
    CGPoint controlPoint2 = CGPointMake(0, 180);
    // 添加三次贝塞尔曲线
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    // 设置另一个起始点
    [path moveToPoint:endPoint];
    // 设置第三个控制点
    CGPoint controlPoint3 = CGPointMake(rect.size.width-100, 20);
    // 设置第四个控制点
    CGPoint controlPoint4 = CGPointMake(rect.size.width, 180);
    // 添加三次贝塞尔曲线
    [path addCurveToPoint:startPoint controlPoint1:controlPoint4 controlPoint2:controlPoint3];
  
    keyframeAnimation.path = path.CGPath;
    [testLayer addAnimation:keyframeAnimation forKey:@"heartPath"];
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
