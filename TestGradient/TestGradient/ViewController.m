//
//  ViewController.m
//  TestGradient
//
//  Created by Kosuke Matsuda on 2013/04/23.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "GradientView.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    GradientView *v = [[GradientView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
