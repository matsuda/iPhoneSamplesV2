//
//  ScanViewController.h
//  TestQRCode
//
//  Created by Kosuke Matsuda on 2014/12/03.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 QRCode

 http://d.hatena.ne.jp/wwwcfe/20130924/ios7_sdk_qr_ean13
 http://qiita.com/hkato193/items/c36a940c2929a124e416
 http://www.ama-dev.com/iphone-qr-code-library-ios-7/
 */
@protocol ScanViewControllerDelegate;

@interface ScanViewController : UIViewController
@property (weak, nonatomic) id <ScanViewControllerDelegate> delegate;
@end

@protocol ScanViewControllerDelegate <NSObject>

- (void)scanViewController:(ScanViewController *)controller didScanQRCodeValue:(NSString *)value;

@end