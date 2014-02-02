//
//  SecondCell.m
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

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

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    self.label1.preferredMaxLayoutWidth = bounds.size.width - 20*2;
    self.label2.preferredMaxLayoutWidth = bounds.size.width - 20*2;
    self.label3.preferredMaxLayoutWidth = bounds.size.width - 20*2;
    [super layoutSubviews];
}

- (void)updateConstraints
{
    [super updateConstraints];
    Order *order = self.order;
    // TODO
    if (order.hideText1 || order.hideText2) {
        self.verticalSpace1.constant = 0.f;
    } else {
        self.verticalSpace1.constant = 10.f;
    }
    if (order.hideText2 || order.hideText3) {
        self.verticalSpace2.constant = 0.f;
    } else {
        self.verticalSpace2.constant = 10.f;
    }
}

@end
