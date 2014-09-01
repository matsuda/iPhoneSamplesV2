//
//  ViewController.m
//  TestBeacon
//
//  Created by Kosuke Matsuda on 2014/08/29.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"

NSString *BeaconIdentifier = @"com.example.test-beacon";
NSString *BeaconUUID = @"4DF4F424-546E-429C-8E3F-CE4319A9251A";

@import CoreLocation;

@interface ViewController () <CLLocationManagerDelegate, NSURLSessionDownloadDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSUUID *uuid;
@property (strong, nonatomic) CLBeaconRegion *region;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        // UUID
        self.uuid = [[NSUUID alloc] initWithUUIDString:BeaconUUID];
        self.region = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid identifier:BeaconIdentifier];
        NSLog(@"authorizationStatus >>>> %d", [CLLocationManager authorizationStatus]);
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            [self updateMonitoredRegion];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startMonitor:(id)sender
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [self updateMonitoredRegion];
    }
}

- (IBAction)stopMonitor:(id)sender
{
    [self stopMonitoredRegion];
}

- (NSURLSession *)session
{
    if (!_session) {
        NSString *identifier = @"BackgroundSessionConfiguration";
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:identifier];
        NSLog(@"configuration >>> %@", configuration);
        NSLog(@"identifier >>> %@", configuration.identifier);
        NSLog(@"networkServiceType >>> %d", configuration.networkServiceType);
        NSLog(@"discretionary >>> %d", configuration.discretionary);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        APPLog(@"session >>>>> %@", session);
        _session = session;
    }
    return _session;
}

- (void)updateMonitoredRegion
{
    [self.locationManager startMonitoringForRegion:self.region];
    self.leftBarButton.enabled = NO;
    self.rightBarButton.enabled = YES;
}

- (void)stopMonitoredRegion
{
    if ([CLLocationManager isRangingAvailable]) {
        [self.locationManager stopRangingBeaconsInRegion:self.region];
    }
    [self.locationManager stopMonitoringForRegion:self.region];
    self.leftBarButton.enabled = YES;
    self.rightBarButton.enabled = NO;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    APPLog(@"%d", status);
    if (status != kCLAuthorizationStatusAuthorized) {
        [self stopMonitoredRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    APPLog();
    [self.locationManager requestStateForRegion:self.region];
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    APPLog();
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    APPLog();
    if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    APPLog();
    switch (state) {
        case CLRegionStateInside: {
            NSLog(@"Inside");
            if ([region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable]) {
                [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
            }
            [self startSession];
            break;
        }
        case CLRegionStateOutside:
            NSLog(@"Outside");
            break;
        default:
            NSLog(@"Other");
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
//    APPLog();
    if ([beacons count] > 0) {
        CLBeacon *beacon = [beacons firstObject];
        NSString *message;
        switch (beacon.proximity) {
            case CLProximityImmediate:
                message = @"Range Immediate";
                break;
            case CLProximityNear:
                message = @"Range Near";
                break;
            case CLProximityFar:
                message = @"Range Far";
                break;
            default:
                message = @"Range Unknown";
                break;
        }
        self.statusLabel.text = message;
        self.uuidLabel.text = [beacon.proximityUUID UUIDString];
        self.majorLabel.text = [beacon.major stringValue];
        self.minorLabel.text = [beacon.minor stringValue];
        self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
        self.rssiLabel.text = [NSString stringWithFormat:@"%d", beacon.rssi];
    }
}

- (void)startSession
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.178:9393/coupons/list"];
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    APPLog();
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    APPLog();
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    APPLog(@"location >>>>> %@", location);
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)downloadTask.response;
    APPLog(@"statusCode >>> >%d", (int)response.statusCode);
    if (response.statusCode != 200) {
        return;
    }

    NSData *data = [NSData dataWithContentsOfURL:location];
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"response string >>> %@", str);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json >>>> %@", json);
    if (error) {
        NSLog(@"json error >>> %@", error);
    } else {
        if (json) {
            NSArray *coupons = json[@"coupons"];
            if ([coupons count] > 0) {
                NSDictionary *coupon = [coupons firstObject];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UILocalNotification *notification = [UILocalNotification new];
                    notification.alertBody = [NSString stringWithFormat:@"%@", coupon[@"name"]];
                    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                });
            }
        }
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    APPLog();
    if (error) {
        NSLog(@"error >>>>> %@", error);
    }
    [session invalidateAndCancel];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    APPLog();
}

@end
