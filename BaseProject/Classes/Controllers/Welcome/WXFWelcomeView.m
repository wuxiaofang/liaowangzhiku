//
//  WXFWelcomeView.m
//  BaseProject
//
//  Created by yongche_w on 16/6/7.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFWelcomeView.h"
#import "WXFUser.h"
#import "WXFGuideView.h"


@interface WXFWelcomeView()

@property (nonatomic, strong) UIImageView* launchImageView;

@property (nonatomic, strong) WXFGuideView* guideView;

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
    NSString* social_id = [WXFDevice getIdentifierForVendor];
    NSDictionary* paramater = [NSDictionary dictionaryWithObjectsAndKeys:social_id,@"social_id", nil];
    
    [[WXFHttpClient shareInstance] postData:@"/app/comm/user/auto_login.jspx" parameters:paramater callBack:^(WXFParser *parser) {
        [self hiddenHud];
        NSInteger code = [parser.responseDictionary intSafeForKey:@"code"];
        if(code == 0 && parser.responseDictionary){
            [[WXFUser instance] parseUserInfo:parser.responseDictionary];
        }else{
            [[WXFUser instance] logout];
        }
        if([self needShowGuideView]){
            [self showGuideView];
        }else{
            [self selfDismiss];
        }
        
    }];
    
}

- (void)selfDismiss
{
    [UIView animateWithDuration:0.3 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        
        
        if(self.dismissWelcomeViewBlock){
            self.dismissWelcomeViewBlock(nil);
        }
        [self removeFromSuperview];
        
        
    }];

}

- (void)showGuideView
{
    
    self.guideView = [[WXFGuideView alloc] initWithFrame:self.bounds];
    [self addSubview:self.guideView];
    
    [self.guideView reloadImages:[NSArray arrayWithObjects:[self changeImageNameForDevice:@"guide1"],[self changeImageNameForDevice:@"guide2"], nil]];
    __weak typeof(self) weakSelf = self;
    self.guideView.didSelectBlock = ^(NSInteger index){
        if(index == 1){
//            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"showGuideView"];
            if(weakSelf.dismissWelcomeViewBlock){
                weakSelf.dismissWelcomeViewBlock(nil);
            }
            [weakSelf removeFromSuperview];

        }
    };
}

- (NSString*)changeImageNameForDevice:(NSString*)imageName
{
    if(DeviceIsIphone4){
        
        imageName = [NSString stringWithFormat:@"%@_iphone4",imageName];
        
    }else if(DeviceIsIphone5){
        imageName = [NSString stringWithFormat:@"%@_iphone5",imageName];
    }else if(DeviceIsIphone6){
        imageName = [NSString stringWithFormat:@"%@_iphone6",imageName];
    }else if(DeviceIsIphone6plus){
        imageName = [NSString stringWithFormat:@"%@_iphone6p",imageName];
    }
    return  imageName;
}

- (BOOL)needShowGuideView
{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:@"showGuideView"];
    if(object){
        return NO;
    }
    return YES;
}

@end
