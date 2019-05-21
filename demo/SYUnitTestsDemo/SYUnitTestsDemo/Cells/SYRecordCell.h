//
//  SYRecordCell.h
//  SYUnitTestsDemo
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface SYRecordCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCellInTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath dataSource:(id)dataSource;

- (void)displayCellByDataSources:(id)dataSources rowAtIndexPath:(NSIndexPath *)indexPath;

@end

//NS_ASSUME_NONNULL_END
