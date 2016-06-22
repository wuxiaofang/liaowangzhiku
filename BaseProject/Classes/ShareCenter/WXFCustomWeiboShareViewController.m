//
//  WXFCustomWeiboShareViewController.m
//  BaseProject
//
//  Created by yongche_w on 16/6/11.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "WXFCustomWeiboShareViewController.h"

#import <SDWebImage/SDImageCache.h>

#define MAX_LIMIT_NUMS 110

@interface WXFCustomWeiboShareViewController ()<UITextViewDelegate>{
    UIView *lineView;
    UITextView *myTextView;
    UILabel *remainNumsTextLabel;
    UIImage *remote_shareImage;
}
//分享需要的参数
@property(nonatomic,copy) NSString *shareTitle;
@property(nonatomic,copy) id imageOrURL;
@property(nonatomic,copy) NSString *pageURL;
@end

@implementation WXFCustomWeiboShareViewController
- (id)initWithTitle:(NSString *)shareTitle
    shareImageOrURL:(id)shareImageOrURL
            pageUrl:(NSString *)sharePageUrl callBackFunc:(void(^)(int status, int scene))callBackFunc{
    if (self = [super init])
    {
        self.shareTitle = shareTitle;
        self.imageOrURL = shareImageOrURL;
        self.pageURL = sharePageUrl;
        if (callBackFunc) {
            self.callBack = callBackFunc;
        }
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)createUI{
    self.title = @"分享到新浪微博";
    //创建导航栏右侧的提交按钮
    [self createCommitBarButtonItem];
    //创建文本输入框
    [self createInputTextView];
    //创建还可以输入多少字的Label
    [self createCalculateLabel];
    //创建分享图片
    [self createShareImageView];
}

- (void)createCommitBarButtonItem{
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor
                            colorWithRed:236.0/255.0
                            green:73.0/255.0
                            blue:73.0/255.0
                            alpha:1.0] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    leftBtn.frame = CGRectMake(0.0, 0.0, 35.0, 30.0);
    [leftBtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor
                             colorWithRed:236.0/255.0
                             green:73.0/255.0
                             blue:73.0/255.0
                             alpha:1.0] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.frame = CGRectMake(0.0, 0.0, 35.0, 30.0);
    [rightBtn addTarget:self action:@selector(sendToWeiBo) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)createInputTextView{
    CGFloat width = self.view.width - 30;
    lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, width, 120)];
    lineView.backgroundColor = UIColorFromRGB(0xc8c8c8);
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5, lineView.width - 1, lineView.height - 1)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [lineView addSubview:whiteView];
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, whiteView.width - 10, whiteView.height - 10)];
    [whiteView addSubview:myTextView];
    myTextView.returnKeyType = UIReturnKeyDone;
    myTextView.delegate = self;
    myTextView.font = [UIFont systemFontOfSize:15.0f];
    myTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    myTextView.text = self.shareTitle;
    [self.view addSubview:lineView];
}

- (void)createCalculateLabel{
    remainNumsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, lineView.bottom + 5, self.view.width - 30, 18)];
    remainNumsTextLabel.textColor = UIColorFromRGB(0x888888);
    remainNumsTextLabel.font = [UIFont systemFontOfSize:15.0f];
    remainNumsTextLabel.text = [NSString stringWithFormat:@"%@",@(MAX(0,MAX_LIMIT_NUMS - self.shareTitle.length))];
    remainNumsTextLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:remainNumsTextLabel];
}

- (void)createShareImageView{
    remote_shareImage = self.imageOrURL;
    if ([self.imageOrURL isKindOfClass:[NSString class]]) {
        NSString *imageURL = self.imageOrURL;
        if (imageURL.length > 0) {
            remote_shareImage = nil;
            //添加本地缓存
            remote_shareImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
            if(remote_shareImage == nil){
                remote_shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
                [[SDImageCache sharedImageCache] storeImage:remote_shareImage forKey:imageURL];
            }
        }
    }
    if ([remote_shareImage isKindOfClass:[UIImage class]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(lineView.left, lineView.bottom + 15, 50, 50)];
        imageView.image = remote_shareImage;
        [self.view addSubview:imageView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)sendToWeiBo{
    if (myTextView.text.length == 0) {

        [self showToastWithText:@"内容不可以为空"];
        return;
    }
    
    NSString *wbtoken = getValueForKeyFromUserDefault(kWeiboAccessTokenKey);
    NSString *shareText = myTextView.text;
    if (self.pageURL) {
        shareText = [NSString stringWithFormat:@"%@%@ (分享自@瞭望智库)",myTextView.text,self.pageURL];
    }
    //包装消息
    WBImageObject *image = [WBImageObject object];
    if ([remote_shareImage isKindOfClass:[UIImage class]]) {
        image.imageData = UIImageJPEGRepresentation(remote_shareImage, 0.8);
    }
    [self showHud];
    [WBHttpRequest requestForShareAStatus:shareText contatinsAPicture:image orPictureUrl:nil withAccessToken:wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        [self hiddenHud];
        NSString *alertMessage = @"分享成功";
        if (error){
            alertMessage = error.localizedDescription;
            if(self.callBack) {
                self.callBack(-1,2);
            }
        }else{
            if (self.callBack) {
                self.callBack(0,2);
            }
            [self dismissViewController];
        }
        
    }];
}



- (void)dismissViewController{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx = idx + steplen;//这里变化了，使用了字串占的长度来作为步长
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            remainNumsTextLabel.text = @"0";
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里为了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
    remainNumsTextLabel.text = [NSString stringWithFormat:@"%@",@(MAX(0,MAX_LIMIT_NUMS - existTextNum))];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
