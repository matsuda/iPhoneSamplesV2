//
//  GradientView.m
//  TestIBInspectable
//
//  Created by Kosuke Matsuda on 2015/07/06.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self updateViews];
}

- (void)updateViews
{
    CAGradientLayer *gradient = (CAGradientLayer *)self.layer;
    gradient.colors = @[
                        (id)[UIColor colorWithRed:100/255.0 green:80/255.0 blue:120/255.0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:120/255.0 green:80/255.0 blue:80/255.0 alpha:1].CGColor,
                        ];
}

@end
