//
//  Order.m
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "Order.h"

@implementation Order

+ (id)order
{
    Order *obj = [self new];
    obj.text1 = @"1111111111 1111111111 1111111111 1111111111 1111111111 1111111111";
    obj.text2 = @"2222222222";
    obj.text3 = @"3333333333";
    obj.hideText1 = NO;
    obj.hideText2 = YES;
    obj.hideText3 = NO;
    return obj;
}
@end
