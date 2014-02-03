//
//  TableViewController.m
//  TestAutoLayout
//
//  Created by Kosuke Matsuda on 2014/02/02.
//  Copyright (c) 2014年 Kosuke Matsuda. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "SecondCell.h"

static NSString *kCellIdentifier = @"CustomCell";
//static NSString *kNibName = @"FirstCell";
static NSString *kNibName = @"SecondCell";
//static NSString *kNibName = @"ThirdCell";

@interface TableViewController () {
    CustomCell *_prototypeCell;
}

@property (strong, nonatomic) Order *order;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:kNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    self.order = [Order order];
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _prototypeCell.frame = tableView.bounds;
    _prototypeCell.order = self.order;
    [_prototypeCell setNeedsUpdateConstraints];
    [_prototypeCell updateConstraintsIfNeeded];
    CGSize size = [_prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"size >>>>>>> %@", NSStringFromCGSize(size));
    return size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.order = self.order;
    return cell;
}

@end
