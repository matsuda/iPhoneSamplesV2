//
//  ViewController.m
//  TestCollectionView
//
//  Created by Kosuke Matsuda on 2014/03/11.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"

static NSString *CellIdentifier = @"Cell";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

@end
