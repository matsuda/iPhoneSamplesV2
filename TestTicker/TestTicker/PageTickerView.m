//
//  PageTickerView.m
//  TestTicker
//
//  Created by Kosuke Matsuda on 2013/06/05.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "PageTickerView.h"

#define zStayScrollTimeInterval                 3
#define zScrollTimeInterval                     0.01

@interface PageTickerView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *itemViews;

@end

@implementation PageTickerView {
    NSInteger _numberOfItems;
    NSInteger _topIndex;
    NSInteger _bottomIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupDefault];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)reloadPageTickerView
{
    for (UIView *v in self.itemViews) {
        [v removeFromSuperview];
    }
    [self.itemViews removeAllObjects];
    [self prepareTicker];
}

- (void)layoutSubviews
{
    _numberOfItems = [self.dataSource numberOfItemsInPageTickerView:self];
    NSInteger count = 0;
    for (NSInteger i = 0; i < _numberOfItems; i++) {
        CGRect rect = CGRectZero;
        rect.size = _itemSize;
        rect.origin.y = _itemSize.height * i;
        UIView *view = [self.dataSource pageTickerView:self viewAtIndex:i];
        view.frame = rect;
        [self.scrollView addSubview:view];
        [self.itemViews addObject:view];
        count++;
    }
    _topIndex = 0;
    _bottomIndex = _numberOfItems - 1;
    if (_bottomIndex < 0) {
        _bottomIndex = 0;
    }
    self.scrollView.contentSize = CGSizeMake(_itemSize.width, _itemSize.height * count);
    [self moveOffsetToIndex:0];
    [self startAutoScroll];
}

- (void)setupDefault
{
    self.itemViews = [@[] mutableCopy];
    _itemSize = self.bounds.size;
    [self prepareTicker];
}

- (void)prepareTicker
{
    _numberOfItems = 0;
    _topIndex = 0;
    _bottomIndex = 0;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor orangeColor];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)resetContentOffsetScrollView:(UIScrollView *)scrollView
{
    CGFloat height = _itemSize.height;
    [scrollView setContentOffset:CGPointMake(0, height) animated:NO];
}

- (void)scrollVIew:(UIScrollView *)scrollView willResetOffsetToPositive:(BOOL)positive
{
    [self stopTimerSafety];
    [self startAutoScroll];
}

- (void)adjustItemsInScrollView:(UIScrollView *)scrollView
{
    if (![self.itemViews count]) {
        return;
    }
    CGFloat height = _itemSize.height;
    CGPoint point = scrollView.contentOffset;
    NSInteger maxIndex = _numberOfItems - 1;

    if (point.y >= height*2) {
        [self scrollVIew:scrollView willResetOffsetToPositive:YES];
        UIView *topView = self.itemViews[_topIndex];
        [self.itemViews removeObject:topView];
        [self.itemViews addObject:topView];

        for (UIView *v in self.itemViews) {
            CGRect f = v.frame;
            if (f.origin.y - height < 0) {
                f.origin.y = height * maxIndex;
            } else {
                f.origin.y -= height;
            }
            v.frame = f;
        }
        _topIndex = [self nextBottomIndex:_topIndex];
        _bottomIndex = [self nextBottomIndex:_bottomIndex];
        [self resetContentOffsetScrollView:scrollView];
    } else if (point.y <= 0) {
        [self scrollVIew:scrollView willResetOffsetToPositive:NO];
        UIView *bottomView = self.itemViews[_bottomIndex];
        [self.itemViews removeObject:bottomView];
        [self.itemViews insertObject:bottomView atIndex:0];

        for (UIView *v in self.itemViews) {
            CGRect f = v.frame;
            if (f.origin.y + height < self.scrollView.contentSize.height) {
                f.origin.y += height;
            } else {
                f.origin.y = 0;
            }
            v.frame = f;
        }
        _topIndex = [self nextTopIndex:_topIndex];
        _bottomIndex = [self nextTopIndex:_bottomIndex];
        [self resetContentOffsetScrollView:scrollView];
    }
}

- (void)moveOffsetToIndex:(NSInteger)index
{
    NSInteger maxIndex = _numberOfItems - 1;
    if (index > maxIndex) {
        index = 0;
    } else if (index < 0) {
        index = maxIndex;
    }
    CGPoint point = CGPointMake(_itemSize.width, _itemSize.height * index);
    self.scrollView.contentOffset = point;
    [self adjustItemsInScrollView:self.scrollView];
}

- (NSInteger)nextTopIndex:(NSInteger)index
{
    NSInteger maxIndex = _numberOfItems - 1;
    NSInteger nextIdx = index - 1;
    if (nextIdx < 0) {
        nextIdx = maxIndex;
    }
    return nextIdx;
}

- (NSInteger)nextBottomIndex:(NSInteger)index
{
    NSInteger maxIndex = _numberOfItems - 1;
    NSInteger nextIdx = index + 1;
    if (nextIdx > maxIndex) {
        nextIdx = 0;
    }
    return nextIdx;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self adjustItemsInScrollView:scrollView];
}

#pragma mark - AutoScroll

- (void)stopTimerSafety
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)startAutoScroll
{
    if (_numberOfItems > 0) {
        [NSTimer scheduledTimerWithTimeInterval:zStayScrollTimeInterval target:self selector:@selector(restartAutoScroll) userInfo:nil repeats:NO];
    }
}

- (void)restartAutoScroll
{
    [self stopTimerSafety];
    self.timer = [NSTimer timerWithTimeInterval:zScrollTimeInterval target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerDidFire:(NSTimer *)timer
{
    CGPoint p = self.scrollView.contentOffset;
    p.y += 1;
    CGFloat height = _itemSize.height;
    CGPoint targetOffset = CGPointMake(0, height * 2);
    if (p.y <= targetOffset.y) {
        self.scrollView.contentOffset = p;
    }
}

@end
