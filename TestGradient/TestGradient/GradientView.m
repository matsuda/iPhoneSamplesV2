//
//  GradientView.m
//  TestGradient
//
//  Created by Kosuke Matsuda on 2013/04/23.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "GradientView.h"

@interface GradientView () {
    NSDateComponents *_components;
}

@end

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self restoreConditions];
    }
    return self;
}

/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
        1.f, 1.f, 1.f, 0.5f,
        0.f, 0.f, 0.f, 0.5f,
    };
    CGFloat locations[] = { 0.f, 1.f };
    size_t count = sizeof(components) / (sizeof(CGFloat) * 4);

    CGRect frame = self.bounds;
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
    endPoint.y = frame.origin.y + frame.size.height;

    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);

    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);

    CGContextRestoreGState(context);
}
 */

- (void)restoreConditions
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSHourCalendarUnit;
    NSDateComponents *components = [calendar components:unit fromDate:now];
    NSLog(@"components >>>>>>>> %@", components);
    _components = components;
}

- (void)drawRect:(CGRect)rect
{
    NSInteger hour = _components.hour;
    CGFloat brightness = (1.f - hour / 24.f);
    NSLog(@"%f", brightness);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorArray[] = {
        [UIColor colorWithHue:0.6f saturation:0.5f brightness:brightness alpha:1.f].CGColor,
        [UIColor colorWithRed:0.5f green:0.5f blue:0.6f alpha:1.f].CGColor
    };
    size_t count = sizeof(colorArray) / (sizeof(CGColorRef));
    CFArrayRef colors = CFArrayCreate(kCFAllocatorDefault, (const void **)colorArray, count, &kCFTypeArrayCallBacks);

    /*
     // NSArray
    NSArray *colorArray = @[
                            (id)[UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f].CGColor,
                            (id)[UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f].CGColor
                            ];
    CFArrayRef colors = (__bridge CFArrayRef)colorArray;
     */

    CGFloat locations[] = { 0.4f, 1.f };

    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colors, locations);

    CGRect frame = self.bounds;
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
    endPoint.y = frame.origin.y + frame.size.height;

    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);

    CGContextRestoreGState(context);
}

@end
