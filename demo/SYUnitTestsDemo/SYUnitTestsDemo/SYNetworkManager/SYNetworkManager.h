//
//  SYNetworkManager.h
//  SYUnitTestsDemo
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SYNetworkManagerInstance [SYNetworkManager shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface SYNetworkManager : NSObject

+ (instancetype)shareInstance;

- (void)requestWithService:(NSString *)service completionHandler:(void(^)(NSDictionary *response))completionHandler;

- (void)requestWithService:(NSString *)service parameter:(nullable NSDictionary *)parameter completionHandler:(void(^)(NSDictionary *response))completionHandler;

@end

NS_ASSUME_NONNULL_END
