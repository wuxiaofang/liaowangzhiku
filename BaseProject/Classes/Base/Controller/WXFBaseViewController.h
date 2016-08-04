//
//  WXFBaseViewController.h
//  PublicCoursera
//
//  Created by yongche_w on 16/4/9.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface WXFBaseViewController : UIViewController

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) CGFloat cellHeigth;


/*
 * 是否隐藏到航条：默认  NO
 * YES：隐藏；NO：不隐藏
 **/
@property (nonatomic, assign) BOOL hiddenNavBar;

/*
 * 设置ViewController的title
 */
- (void)setCustomLabelForNavTitle:(NSString*)title;

/*
 * 展示HUD
 */
- (void)showHud;

/*
 * 隐藏HUD
 */
- (void)hiddenHud;

/*
 * show toast
 */
- (void)showToastWithText:(NSString*)text;

/*
 * show success toast
 */
- (void)showSuccessToast;

/*
 * show success toast
 */
- (void)showSuccessToast:(NSString*)text;

/*
 * show failed toast
 */
- (void)showFailedToast;

/*
 * show failed toast
 */
- (void)showFailedToast:(NSString*)text;

/*
 * show nav back button
 */
- (void)showBackButton;

/*
 * show nav left button
 */
- (void)showLeftButtonWithTitle:(NSString *)title;


/*
 * back button action
 * default: popViewControllerAnimated
 */
- (void)backBarButtonPressed:(id)object;


@end
