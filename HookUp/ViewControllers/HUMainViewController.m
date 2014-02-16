//
//  HUMainViewController.m
//  HookUp
//
//  Created by Marcus Mattsson on 16/2/14.
//  Copyright (c) 2014 bitesize. All rights reserved.
//

#import "HUMainViewController.h"

@interface HUMainViewController ()
@property(nonatomic, strong) UITableView *leftTableView;
@property(nonatomic, strong) UITableView *rightTableView;
@end

@implementation HUMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftTableView = [[UITableView alloc] init];
        self.rightTableView = [[UITableView alloc] init];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.leftTableView.backgroundColor = [UIColor redColor];
    self.rightTableView.backgroundColor = [UIColor greenColor];

    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];

    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints {
    [self.leftTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.rightTableView.mas_left);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.rightTableView);
    }];

    [self.rightTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    [super updateViewConstraints];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
