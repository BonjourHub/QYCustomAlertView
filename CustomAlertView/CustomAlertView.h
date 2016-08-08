//
//  CustomAlertView.h
//  homejcb
//
//  Created by 程朋飞 on 15/12/30.
//  Copyright © 2015年 soufun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>

- (void)customAlertViewClickedButtonAtIndex:(NSInteger)buttonIndex sender:(nullable NSDictionary *)sender;

@end

@interface CustomAlertView : NSObject<UIAlertViewDelegate>

/**
 *代理,点击的button坐标
 */
@property (nonatomic, assign, nullable)id<CustomAlertViewDelegate>delegate;

/**
 * 警告框，兼容了 UIAlertView 和 UIAlertController
 * @code
 self.alertView = [CustomAlertView alertViewWithTitle:@"" message:@"请升级为付费用户，才可拨打电话" delegate:self buttonTitleArray:@[@"稍后再说",@"联系客服"] sender:nil];
 * @endcode
 * @attention 必须用一个属性接收实例对象，保证创建完不被释放
 * @param title 提示标题
 * @param message 提示信息
 * @param delegate 代理
 * @param titles 按钮标题数组
 * @param sender 附带信息
 * @author 程朋飞
 * @version 2.0
 * @return 警告框
 */
+ (nullable instancetype)alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nonnull id)delegate buttonTitleArray:(nonnull NSArray *)titles sender:(nullable NSDictionary *)sender;


@end
