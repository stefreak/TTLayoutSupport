//
//  TTDemoTableViewController.m
//  TTLayoutSupport
//
//  Created by Steffen on 25.11.14.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTDemoTableViewController.h"

@interface TTDemoTableViewController ()

@end

@implementation TTDemoTableViewController

static NSString *kReuseIdentifier = @"reuseIdentifier";

- (instancetype)init
{
    self = [super init];

    if (self) {
        self.title = @"UITableViewController";
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"row %@", @(indexPath.row)];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section %@", @(section)];
}

@end
