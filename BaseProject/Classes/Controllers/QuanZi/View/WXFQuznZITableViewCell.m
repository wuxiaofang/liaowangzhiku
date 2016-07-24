//
//  WXFQuznZITableViewCell.m
//  BaseProject
//
//  Created by yongche_w on 16/7/23.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFQuznZITableViewCell.h"

@implementation WXFQuznZITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.gridView1 = [[WXFQuznZIGridView alloc] init];
        [self addSubview:self.gridView1];
        
        self.gridView2 = [[WXFQuznZIGridView alloc] init];
        [self addSubview:self.gridView2];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat gap = 10;
    
    self.gridView1.frame = CGRectMake(margin, gap, (self.width - margin - margin - gap)/2, self.height - gap);
    self.gridView2.frame = CGRectMake(self.width/2 + margin, gap, (self.width - margin - margin - gap)/2, self.height - gap);
}

@end


@implementation WXFQuznZIGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.profileImageView = [[UIImageView alloc] init];
        self.profileImageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.profileImageView];
        
        self.userHeaderImageView = [[UIImageView alloc] init];
        self.userHeaderImageView.layer.cornerRadius = 15;
        self.userHeaderImageView.layer.masksToBounds = YES;
        self.userHeaderImageView.backgroundColor = [UIColor blueColor];
        [self addSubview:self.userHeaderImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        
        self.usernameLabel = [[UILabel alloc] init];
        self.usernameLabel.textColor = UIColorFromRGB(0x828282);
        self.usernameLabel.font = [UIFont systemFontOfSize:12.0f];
        self.usernameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.usernameLabel];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tapPress
{
    if(self.quanZiDidBlock){
        self.quanZiDidBlock(self.dic);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.profileImageView.frame = CGRectMake(0, 0, self.width, self.height / 2 + 5);
    
    self.userHeaderImageView.frame = CGRectMake(10, self.profileImageView.bottom - 4, 30, 30);

    self.usernameLabel.left = self.userHeaderImageView.right + 5;
    self.usernameLabel.centerY = self.userHeaderImageView.centerY;
    

    
    self.titleLabel.left = 10;
    self.titleLabel.top = self.userHeaderImageView.bottom + 5;
}

- (void)reloadData:(NSDictionary*)dictionary
{
    self.dic = dictionary;
    NSString* title = [dictionary stringSafeForKey:@"title"];
    NSString* cover = [dictionary stringSafeForKey:@"cover"];
    NSDictionary* admin = [dictionary dictionarySafeForKey:@"admin"];
    NSString* userImg = [admin stringSafeForKey:@"userImg"];
    NSString* username = [admin stringSafeForKey:@"username"];
    
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    self.usernameLabel.text = [NSString stringWithFormat:@"版主：%@",username];
    [self.usernameLabel sizeToFit];
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userImg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if([imageURL.absoluteString isEqualToString:userImg]){
            self.userHeaderImageView.image = image;
        }else{
            self.userHeaderImageView.image = nil;
        }
    }];

    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if([imageURL.absoluteString isEqualToString:cover]){
            self.profileImageView.image = image;
        }else{
            self.profileImageView.image = nil;
        }
    }];

    
}



@end
