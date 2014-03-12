//
//  CustomViewController.m
//  TestCollectionView
//
//  Created by Kosuke Matsuda on 2014/03/12.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "CustomViewController.h"
#import "CustomCell.h"

static NSString *CellIdentifier = @"Cell";

@interface CustomViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *items;

@end

@implementation CustomViewController

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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCell class]) bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    NSInteger count = 30;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        int r = arc4random() % 10;
        [array addObject:@(r)];
    }
    self.items = [NSArray arrayWithArray:array];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSInteger count = 3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [CustomCell itemSize];
    CGSize size = self.collectionView.bounds.size;
    CGFloat space = (size.width - layout.itemSize.width * count) / (count + 1);
    layout.minimumInteritemSpacing = space;
    layout.minimumLineSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake(20, space, 20, space);
    [self.collectionView setCollectionViewLayout:layout animated:YES completion:^(BOOL finished) {
        NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
        [self.collectionView reloadItemsAtIndexPaths:indexPaths];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int r = [self.items[indexPath.row] intValue];
    cell.label.text = [NSString stringWithFormat:@"%d", r+1];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d", r+1]];
    [cell setNeedsDisplay];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.number = indexPath.row;
}

@end
