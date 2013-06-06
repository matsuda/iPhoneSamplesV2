//
//  ViewController.m
//  TestFacebookSDK
//
//  Created by Kosuke Matsuda on 2013/06/03.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.dhc.co.jp/goods/goodsdetail.jsp?gCode=22504"];
    FBAppCall *result = [FBDialogs presentShareDialogWithLink:url
//                                                       name:@"test share"
                                                    handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
        if(error) {
            NSLog(@"Error: %@", error.description);
        } else {
            NSLog(@"Success!");
        }
    }];
    NSLog(@"cccccccccc >>>>>>>>>> %@", result);
    if (!result) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share" message:@"can't share" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        NSDictionary *params = @{@"naem": @"FBTest",
//                                 @"caption": @"caption test",
//                                 @"description": @"test ios SDK",
//                                 @"link": @"http://www.dhc.co.jp/goods/goodsdetail.jsp?gCode=22504",
//                                 @"image": @"http://www.dhc.co.jp/goods/4/22504_L.jpg"};
//        [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
//            NSLog(@"result >>>>> %d", result);
//            NSLog(@"resultURL >>> %@", resultURL);
//            if(error) {
//                NSLog(@"Error: %@", error.description);
//            } else {
//                NSLog(@"Success!");
//            }
//        }];
    }
}

@end
