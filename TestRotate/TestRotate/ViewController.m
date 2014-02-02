//
//  ViewController.m
//  TestRotate
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "ViewController.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface ViewController ()
{
    BOOL _isRotated;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton:(id)sender
{
    [self animate];
}

- (void)animate
{
    CALayer *layer = self.button.layer;
    NSLog(@"layer.frame >>> %@", NSStringFromCGRect(layer.frame));
    NSLog(@"button.frame >>>>>> %@", NSStringFromCGRect(self.button.frame));
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithDouble:_isRotated ? DEGREES_TO_RADIANS(270) : DEGREES_TO_RADIANS(360)];
    anim.toValue = [NSNumber numberWithDouble:_isRotated ? DEGREES_TO_RADIANS(360) : DEGREES_TO_RADIANS(270)];
    anim.duration = 0.5f;
    anim.cumulative = YES;
    anim.repeatCount = 1;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.button.layer addAnimation:anim forKey:@"rotate"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    self.button.layer.frame = ({
//        CGRect frame = self.button.layer.frame;
//        frame.origin.y = CGRectGetMaxY(frame);
//        frame;
//    });
    CGAffineTransform t1 = CGAffineTransformMakeRotation(_isRotated ? DEGREES_TO_RADIANS(360) : DEGREES_TO_RADIANS(270));
    CGAffineTransform t2 = CGAffineTransformMakeTranslation(100, 100);
    CGAffineTransform t = CGAffineTransformConcat(t1, t2);
    self.button.transform = t;
    [self.button.layer removeAnimationForKey:@"rotate"];
    _isRotated = !_isRotated;
    CALayer *layer = self.button.layer;
    NSLog(@"layer.frame >>> %@", NSStringFromCGRect(layer.frame));
    NSLog(@"button.frame >>>>>> %@", NSStringFromCGRect(self.button.frame));
}

- (void)setup
{
    /*
    CALayer *layer = [CALayer layer];
    layer.frame = self.button.bounds;
//    layer.frame = CGRectMake(0, 50, 50, 50);
//    layer.frame = CGRectInset(self.button.bounds, 25, 25);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    NSLog(@"position >>> %@", NSStringFromCGPoint(layer.position));
    NSLog(@"frame >>> %@", NSStringFromCGRect(layer.frame));
    layer.anchorPoint = CGPointMake(1, 0);
    NSLog(@"position >>> %@", NSStringFromCGPoint(layer.position));
    NSLog(@"frame >>> %@", NSStringFromCGRect(layer.frame));
    CGPoint point = CGPointMake(layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - 0.5),
                                layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - 0.5));
    NSLog(@"%@", NSStringFromCGPoint(point));
    layer.position = point;
    [self.button.layer addSublayer:layer];
     */

//    /*
    CALayer *layer = self.button.layer;
//    NSLog(@"position >>> %@", NSStringFromCGPoint(layer.position));
//    NSLog(@"frame >>> %@", NSStringFromCGRect(layer.frame));
    layer.anchorPoint = CGPointMake(1, 1);
//    NSLog(@"position >>> %@", NSStringFromCGPoint(layer.position));
//    NSLog(@"frame >>> %@", NSStringFromCGRect(layer.frame));
    CGPoint point = CGPointMake(layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - 0.5),
                                layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - 0.5));
//    NSLog(@"%@", NSStringFromCGPoint(point));
    layer.position = point;
//     */
}

@end
