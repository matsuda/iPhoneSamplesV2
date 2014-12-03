//
//  ViewController.m
//  TestQRCode
//
//  Created by Kosuke Matsuda on 2014/12/03.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"

@interface ViewController () <ScanViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StartScanSegue"]) {
        ScanViewController *qr = (ScanViewController *)[[(UINavigationController *)segue.destinationViewController viewControllers] firstObject];
        qr.delegate = self;
    }
}

- (IBAction)unwindToRoot:(UIStoryboardSegue *)segue
{
}

- (void)scanViewController:(ScanViewController *)controller didScanQRCodeValue:(NSString *)value
{
    [controller dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
