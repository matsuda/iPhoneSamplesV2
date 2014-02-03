//
//  FirstCell.m
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)updateConstraints
{
    [super updateConstraints];
    UILabel *label1 = self.label1;
    UILabel *label2 = self.label2;
    UILabel *label3 = self.label3;
    Order *order = self.order;
//    NSLog(@"contentView.constraints >>>> %@", self.contentView.constraints);
    [self.contentView removeConstraints:self.contentView.constraints];
    {
        NSDictionary *views = NSDictionaryOfVariableBindings(label1);
//        [label1.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=20)-[label1(==280)]-(>=20)-|"
//                                                                           options:NSLayoutFormatAlignAllCenterX
//                                                                           metrics:nil
//                                                                             views:views]];
        [label1.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[label1(==21)]"
                                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                                 metrics:nil
                                                                                   views:views]];
        [label1.superview addConstraint:[NSLayoutConstraint constraintWithItem:label1
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:label1.superview
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.f constant:0.f]];
    }
}

@end
