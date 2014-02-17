//
//  HUMainViewController.m
//  HookUp
//
//  Created by Marcus Mattsson on 16/2/14.
//  Copyright (c) 2014 bitesize. All rights reserved.
//

#import "HUMainViewController.h"
#import "FBLoginView.h"
#import "FBRequestConnection.h"
#import "HUMainTableViewCell.h"

@interface HUMainViewController ()
@property(nonatomic, strong) UITableView *leftTableView;
@property(nonatomic, strong) UITableView *rightTableView;
@property(nonatomic, strong) FBLoginView *loginView;
@property(nonatomic, strong) NSArray *leftTableViewData;
@property(nonatomic, strong) NSArray *rightTableViewData;
@end

@implementation HUMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftTableView = [[UITableView alloc] init];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        self.rightTableView = [[UITableView alloc] init];
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;

        [self.leftTableView registerClass:[HUMainTableViewCell class]
                   forCellReuseIdentifier:[HUMainTableViewCell identifier]];

        [self.rightTableView registerClass:[HUMainTableViewCell class]
                   forCellReuseIdentifier:[HUMainTableViewCell identifier]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.leftTableView.backgroundColor = [UIColor redColor];
    self.rightTableView.backgroundColor = [UIColor blueColor];

    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];

    self.loginView = [[FBLoginView alloc] init];
    self.loginView.delegate = self;
    [self.view addSubview:self.loginView];

    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];

}

- (void)updateViewConstraints {
    
    [self.loginView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    loginView.hidden = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id <FBGraphUser>)user {

    NSDictionary *params = @{@"fields": @"gender,name"};
    [FBRequestConnection startWithGraphPath:@"/me/friends" parameters:params HTTPMethod:nil completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSLog(@"%@", result[@"data"]);

            self.leftTableViewData = [((NSDictionary *)result[@"data"]).rac_sequence filter:^BOOL(NSDictionary *userObj) {
                return [userObj[@"gender"] isEqual:@"female"];
            }].array;

            self.rightTableViewData = [((NSDictionary *)result[@"data"]).rac_sequence filter:^BOOL(NSDictionary *userObj) {
                return [userObj[@"gender"] isEqual:@"male"];
            }].array;

            [self.leftTableView reloadData];
            [self.rightTableView reloadData];
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView == self.leftTableView ? self.leftTableViewData.count : self.rightTableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HUMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HUMainTableViewCell identifier]];

    NSDictionary *data = tableView == self.leftTableView ? self.leftTableViewData[indexPath.item] : self.rightTableViewData[indexPath.item];
    cell.titleLabel.text = data[@"name"];

    return cell;
}


@end
