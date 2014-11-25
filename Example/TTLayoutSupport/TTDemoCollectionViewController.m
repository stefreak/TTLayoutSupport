//
//  TTDemoCollectionViewController.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTDemoCollectionViewController.h"

@interface TTDemoCollectionViewController ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation TTDemoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 44, 0);

    self = [super initWithCollectionViewLayout:layout];

    if (self) {
        self.title = @"UICollectionViewController";
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.colors = @[
                    [UIColor cyanColor],
                    [UIColor orangeColor],
                    [UIColor yellowColor],
                    [UIColor redColor],
                    ];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIColor *color = self.colors[indexPath.item % (self.colors.count-1)];
    cell.contentView.backgroundColor = color;

    return cell;
}

@end
