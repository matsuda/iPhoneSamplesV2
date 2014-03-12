//
//  CustomCell.m
//  TestCollectionView
//
//  Created by Kosuke Matsuda on 2014/03/12.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation CustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.numberLabel.hidden = YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 196.0/255.0, 196.0/255.0, 196.0/255.0, 1.0);
    // CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGFloat width = 0.5f;
    CGContextSetLineWidth(context, width);
    CGContextStrokeRect(context, self.imageView.frame);
    self.numberLabel.hidden = YES;
}

- (void)setNumber:(NSInteger)number
{
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @(number)];
    self.numberLabel.hidden = NO;
}

+ (CGSize)itemSize
{
    return CGSizeMake(80, 120);
}

@end
