//
//  ViewController.h
//  TestSQLCipher
//
//  Created by Kosuke Matsuda on 2014/04/22.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMDatabase;
@interface ViewController : UIViewController

@property (strong, nonatomic) FMDatabase *database;

@end
