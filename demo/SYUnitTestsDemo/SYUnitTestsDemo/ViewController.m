//
//  ViewController.m
//  SYUnitTestsDemo
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import "ViewController.h"
#import "SYConstant.h"
#import "SYNetworkManager.h"
#import "SYRecordCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;


@property (nonatomic, strong) NSMutableArray *recordList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Record List"];
    [self requestRecordList];
    [self initial];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initial {
    self.recordList = [[NSMutableArray alloc] init];
    [kNotificationCenter addObserverForName:kRecordDoneNotificationKey object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self requestRecordList];
    }];
}

#pragma mark - RequestMethod
- (void)requestRecordList {
    [SYNetworkManagerInstance requestWithService:apiRecordList completionHandler:^(NSDictionary *response) {
        self.recordList = [[NSMutableArray alloc] initWithArray:response[@"data"]];
        if (self.recordList.count > 0) {
            [self.mTableView reloadData];
            self.mTableView.hidden = NO;
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
            self.mTableView.hidden = YES;
        }
    }];
}

- (void)deleteRecordWithIndex:(NSInteger)index completionHandler:(void(^)(NSDictionary *response))completionHandler{
    [SYNetworkManagerInstance requestWithService:apiRecordDelete parameter:@{@"index": @(index)} completionHandler:^(NSDictionary *response) {
        if (completionHandler) {
            completionHandler(response);
        }
    }];
    
}

#pragma mark - IBAction
- (IBAction)tapAddRecordAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *goVC = [storyboard instantiateViewControllerWithIdentifier:@"SYRecordViewController"];
    [self.navigationController pushViewController:goVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.recordList.count > 0
    ?1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SYRecordCell heightForCellInTableView:tableView rowAtIndexPath:indexPath dataSource:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYRecordCell *cell = [SYRecordCell cellForTableView:tableView];
    [cell displayCellByDataSources:self.recordList rowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteRecordWithIndex:indexPath.row completionHandler:^(NSDictionary *response) {
            [self.recordList removeObjectAtIndex:indexPath.row];
            if (self.recordList.count == 0) {
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self requestRecordList];
            } else {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }
}


@end
