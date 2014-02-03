//
//  CustomCell.h
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

typedef NS_OPTIONS(NSUInteger, SpacerType) {
    SpacerTypeNone = 0,
    SpacerType1 = 1 << 0,
    SpacerType2 = 1 << 1,
};

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) Order *order;
@property (assign, nonatomic) SpacerType spacer;

@end
