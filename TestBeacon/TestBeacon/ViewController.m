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

@interface ViewController () <CLLocationManagerDelegate>
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

@end
