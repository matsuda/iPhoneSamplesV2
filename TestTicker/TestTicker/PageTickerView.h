//
//  PageTickerView.h
//  TestTicker
//
//  Created by Kosuke Matsuda on 2013/06/05.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageTickerViewDataSource;


@interface PageTickerView : UIView

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) id <PageTickerViewDataSource> dataSource;
@property (assign, nonatomic) CGSize itemSize;

- (void)reloadPageTickerView;

@end

@protocol PageTickerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPageTickerView:(PageTickerView *)pageTickerView;
- (UIView *)pageTickerView:(PageTickerView *)pageTickerView viewAtIndex:(NSInteger)index;

@end
