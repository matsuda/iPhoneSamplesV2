//
//  GradientView.h
//  TestIBInspectable
//
//  Created by Kosuke Matsuda on 2015/07/06.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GradientView : UIView

@property (nonatomic) IBInspectable UIColor *startColor;
@property (nonatomic) IBInspectable UIColor *endColor;
@property (nonatomic, getter=isHorizontal) IBInspectable BOOL horizontal;

@end
