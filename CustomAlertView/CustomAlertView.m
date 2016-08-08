//
//  CustomAlertView.m
//  homejcb
//
//  Created by 程朋飞 on 15/12/30.
//  Copyright © 2015年 soufun. All rights reserved.
//

#import "CustomAlertView.h"


#define IOS8_BEFOR [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0

@interface CustomAlertView ()

@property (nonnull, strong)UIAlertView *alertView;
@property (nonatomic, strong, nullable)NSDictionary *sender;

@end

@implementation CustomAlertView

#pragma mark 便利构造器
+ (nullable instancetype)alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nonnull id)delegate buttonTitleArray:(nonnull NSArray *)titles sender:(nullable NSDictionary *)sender  {
    
    CustomAlertView *alertView = [[self alloc] initWithTitle:title message:message delegate:delegate buttonTitleArray:titles sender:sender];

    return alertView;
}

#pragma mark - 初始化
-(nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nonnull id)delegate buttonTitleArray:(nonnull NSArray *)titles sender:(nullable NSDictionary *)sender {

    self = [super init];
    if (self) {
        
        if (IOS8_BEFOR) {
        
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.title = title;
            alertView.message = message;
            alertView.delegate = self;
            self.sender = sender;
            self.delegate = delegate;
            
            for (NSString *buttonTitle in titles) {
                
                [alertView addButtonWithTitle:buttonTitle];
            }
            [alertView show];
            
        }
        
        else {

            UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            self.delegate = delegate;
            
            for (int index = 0; index < titles.count; index++) {
                
                NSString *buttonTitle = [titles objectAtIndex:index];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
                    
                    [self alertActionWithActionTitle:action.title titles:titles sender:sender];
                    
                }];
                [aler addAction:action];
            }
            [delegate presentViewController:aler animated:YES completion:nil];
        }
    }
    
    return self;
}

#pragma mark UIAlertController UIAlertAction
- (void)alertActionWithActionTitle:(NSString *)actionTitile titles:(NSArray *)titles sender:(nullable NSDictionary *)sender {

    for (NSString *title in titles) {
        //获取对应action坐标坐标
        if ([title isEqualToString:actionTitile]) {
            
            NSInteger buttonIdex = [titles indexOfObject:title];
            if (self.delegate && [self.delegate respondsToSelector:@selector(customAlertViewClickedButtonAtIndex:sender:)]) {
                [self.delegate customAlertViewClickedButtonAtIndex:buttonIdex sender:sender];
            }
        }
    }
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (self.delegate && [self.delegate respondsToSelector:@selector(customAlertViewClickedButtonAtIndex:sender:)]) {
        [self.delegate customAlertViewClickedButtonAtIndex:buttonIndex sender:self.sender];
    }
}

@end
