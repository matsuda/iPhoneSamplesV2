//
//  CustomCell.h
//  TestCollectionView
//
//  Created by Kosuke Matsuda on 2014/03/12.
//  Copyright (c) 2014年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) NSInteger number;

+ (CGSize)itemSize;

@end
