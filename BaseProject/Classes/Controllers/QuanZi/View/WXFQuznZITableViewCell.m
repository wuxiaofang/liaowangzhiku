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
    
    
    self.gridView1.frame = CGRectMake(10, 10, (self.width - 20 - 5 )/2, self.height - 10);
    self.gridView2.frame = CGRectMake(self.width/2 + 2.5, 10, (self.width - 20 - 5)/2, self.height - 10);
}

@end


@implementation WXFQuznZIGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
    
        self.profileImageView = [[UIImageView alloc] init];
        self.profileImageView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:self.profileImageView];
        
        self.userHeaderImageView = [[UIImageView alloc] init];
        self.userHeaderImageView.layer.cornerRadius = 17;
        self.userHeaderImageView.layer.masksToBounds = YES;
        self.userHeaderImageView.backgroundColor = UIColorFromRGB(0xcccccc);
      
        [self addSubview:self.userHeaderImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.titleLabel];
        
        
        self.usernameLabel = [[UILabel alloc] init];
        self.usernameLabel.textColor = UIColorFromRGB(0x828282);
        self.usernameLabel.font = [UIFont systemFontOfSize:11.0f];
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
    self.profileImageView.frame = CGRectMake(0, 0, self.width, 110);
    
    self.userHeaderImageView.frame = CGRectMake(8, self.profileImageView.bottom - 10, 35, 35);

    self.usernameLabel.left = self.userHeaderImageView.right + 5;
    self.usernameLabel.top = self.profileImageView.bottom + 5;
    self.usernameLabel.width = self.width - self.usernameLabel.left - 10;
    

    self.titleLabel.left = 10;
    self.titleLabel.top = self.userHeaderImageView.bottom + 5;
    self.titleLabel.width = self.width - 15;
    
    CGSize size = [self.titleLabel.text sizeForFont:self.titleLabel.font size:CGSizeMake(self.width - 15, 999) mode:self.titleLabel.lineBreakMode];
    self.titleLabel.height = size.height;
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

    
    self.usernameLabel.text = [NSString stringWithFormat:@"版主：%@",username];
    [self.usernameLabel sizeToFit];
//    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userImg] placeholderImage:[UIImage imageNamed:@"default_head"]];
    self.userHeaderImageView.contentMode = UIViewContentModeCenter;
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userImg] placeholderImage:[UIImage imageNamed:@"default_head_quanzi"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image && [imageURL.absoluteString isEqualToString:userImg]){
            self.userHeaderImageView.image = image;
            self.userHeaderImageView.contentMode = UIViewContentModeScaleToFill;
        }else{
            self.userHeaderImageView.image = [UIImage imageNamed:@"default_head_quanzi"];
            self.userHeaderImageView.contentMode = UIViewContentModeCenter;
        }
    }];

    self.profileImageView.contentMode = UIViewContentModeCenter;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:[UIImage imageNamed:@"default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image && [imageURL.absoluteString isEqualToString:cover]){
            self.profileImageView.image = image;
            self.profileImageView.contentMode = UIViewContentModeScaleToFill;
            
        }else{
            self.profileImageView.image = [UIImage imageNamed:@"default_img"];
            self.profileImageView.contentMode = UIViewContentModeCenter;
        }
    }];

    
}



@end
