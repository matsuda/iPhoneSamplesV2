//
//  ScanViewController.m
//  TestQRCode
//
//  Created by Kosuke Matsuda on 2014/12/03.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.session = [AVCaptureSession new];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [self.session addInput:input];
    
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:output];
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    NSLog(@"%@", output.availableMetadataObjectTypes);
    NSLog(@"%@", output.metadataObjectTypes);
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.frame = self.view.bounds;
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:preview];

    [self startScan];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startScan];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopScan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)startScan
{
    [self.session startRunning];
}

- (void)stopScan
{
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject *metadata in metadataObjects) {
        NSLog(@"type >>>> %@", metadata.type);
        if (![metadata isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            continue;
        }
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString *qrcode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            NSLog(@"qrcode >>> %@", qrcode);
            // [self.delegate scanViewController:self didScanQRCodeValue:qrcode];
            NSString *message = [NSString stringWithFormat:@"QRCode : %@", qrcode];
            [[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self
                              cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] show];
            [self stopScan];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex == buttonIndex) {
        [self startScan];
        return;
    }
    [self.delegate scanViewController:self didScanQRCodeValue:nil];
}

@end
