//
//  Order.h
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (copy, nonatomic) NSString *text1;
@property (copy, nonatomic) NSString *text2;
@property (copy, nonatomic) NSString *text3;
@property (assign, nonatomic) BOOL hideText1;
@property (assign, nonatomic) BOOL hideText2;
@property (assign, nonatomic) BOOL hideText3;

+ (id)order;

@end
