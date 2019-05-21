//
//  SYRecordViewController.m
//  SYUnitTestsDemo
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import "SYRecordViewController.h"
#import "SYNetworkManager.h"
#import "SYConstant.h"

@interface SYRecordViewController ()

@property (weak, nonatomic) IBOutlet UITextView *mTextView;
@property (nonatomic, strong) NSString *tempRecordString;

@end

@implementation SYRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Write Anything"];
}

- (void)saveRecordWithMsg:(NSString *)msg {
    NSNumber *timeStamp = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
    NSLog(@"--%@",timeStamp);
    [SYNetworkManagerInstance requestWithService:apiRecordSave parameter:@{@"msg":msg,@"timeStamp":timeStamp} completionHandler:^(NSDictionary *response) {
        [kNotificationCenter postNotificationName:kRecordDoneNotificationKey object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mTextView becomeFirstResponder];
}


- (IBAction)recordDoneAction:(id)sender {
    if (self.tempRecordString) {
        [self saveRecordWithMsg:self.tempRecordString];
    }else{
        NSLog(@"您还没有输入任何内容！");
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.tempRecordString = textView.text;
}


@end
