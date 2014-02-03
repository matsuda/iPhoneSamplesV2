//
//  CustomCell.m
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.spacer = SpacerTypeNone;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.spacer = SpacerTypeNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    self.label1.backgroundColor = [UIColor redColor];
    self.label2.backgroundColor = [UIColor blueColor];
    self.label3.backgroundColor = [UIColor greenColor];
    self.label1.textColor = [UIColor whiteColor];
    self.label2.textColor = [UIColor whiteColor];
    self.label3.textColor = [UIColor whiteColor];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.label1.translatesAutoresizingMaskIntoConstraints = NO;
//    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
//    self.label3.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setOrder:(Order *)order
{
    _order = order;
    [self layoutOrder:order];
//    NSLog(@"contentView.constraints >>>> %@", self.contentView.constraints);
//    NSLog(@"label1.constraints >>>> %@", self.label1.constraints);
//    NSLog(@"label2.constraints >>>> %@", self.label2.constraints);
//    NSLog(@"label3.constraints >>>> %@", self.label3.constraints);
}

- (void)layoutOrder:(Order *)order
{
    if (order.hideText1) {
        self.label1.text = nil;
    } else {
        self.label1.text = order.text1;
    }
    if (order.hideText2) {
        self.label2.text = nil;
    } else {
        self.label2.text = order.text2;
    }
    if (order.hideText3) {
        self.label3.text = nil;
    } else {
        self.label3.text = order.text3;
    }
}

@end
