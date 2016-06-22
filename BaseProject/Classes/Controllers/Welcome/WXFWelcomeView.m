//
//  WXFWelcomeView.m
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFWelcomeView.h"
#import "WXFUser.h"

@interface WXFWelcomeView()

@property (nonatomic, strong) UIImageView* launchImageView;

@end

@implementation WXFWelcomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.launchImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.launchImageView];
        
        if(DeviceIsIphone4){
            self.launchImageView.image = [UIImage imageNamed:@"welcome_iphone4"];
        }else if(DeviceIsIphone5){
            self.launchImageView.image = [UIImage imageNamed:@"welcome_iphone5"];
        }else if(DeviceIsIphone6){
            self.launchImageView.image = [UIImage imageNamed:@"welcome_iphone6"];
        }else if(DeviceIsIphone6plus){
            self.launchImageView.image = [UIImage imageNamed:@"welcome_iphone6p"];
        }
        [self dismiss];
    }
    return self;
}

- (void)dismiss
{
    [self showHud];
    NSString* social_id = [[UIDevice currentDevice] uuid];
    NSDictionary* paramater = [NSDictionary dictionaryWithObjectsAndKeys:social_id,@"social_id", nil];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/user/auto_login.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        
        NSInteger code = [parser.responseDictionary intSafeForKey:@"code"];
        if(code == 0){
            [[WXFUser instance] parseUserInfo:parser.responseDictionary];
        }
        
        [UIView animateWithDuration:0.3 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self hiddenHud];
            [self removeFromSuperview];
        }];
        
    }];
    
}

@end
