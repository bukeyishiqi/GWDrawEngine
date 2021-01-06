//
//  CustomRefreshFooter.m
//  icar
//
//  Created by 陈琪 on 2020/3/11.
//  Copyright © 2020 Carisok. All rights reserved.
//

#import "CustomRefreshFooter.h"

@interface CustomRefreshFooter ()

@property (nonatomic, strong) UIColor *lineBgColor;

@end

@implementation CustomRefreshFooter

/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock lineBgColor:(UIColor *)bgColor
{
    CustomRefreshFooter *footer =  [super footerWithRefreshingBlock: refreshingBlock];
    footer.lineBgColor = bgColor;
    return footer;
}
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action lineBgColor:(UIColor *)bgColor
{
    CustomRefreshFooter *footer = [super footerWithRefreshingTarget: target refreshingAction: action];
    footer.lineBgColor = bgColor;
    return footer;
}



- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    if (state == MJRefreshStateNoMoreData) {
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        //设置Attachment
        NSTextAttachment *letftAttachment = [[NSTextAttachment alloc] init];
        //使用一张图片作为Attachment数据
        letftAttachment.image = [self leftLine];
        //这里bounds的x值并不会产生影响
        letftAttachment.bounds = CGRectMake(0, 0, letftAttachment.image.size.width, letftAttachment.image.size.height);
        NSAttributedString *left =  [NSAttributedString attributedStringWithAttachment:letftAttachment];
        
        NSTextAttachment *rightAttachment = [[NSTextAttachment alloc] init];
        //使用一张图片作为Attachment数据
        rightAttachment.image = [self rightLine];
        //这里bounds的x值并不会产生影响
        rightAttachment.bounds = CGRectMake(0, 0, rightAttachment.image.size.width, rightAttachment.image.size.height);
        NSAttributedString *right =  [NSAttributedString attributedStringWithAttachment:rightAttachment];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@" 到底了 "];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:left];
        [attributedString appendAttributedString:text];
        [attributedString appendAttributedString:right];
        
        self.stateLabel.attributedText = attributedString;
    }
}

- (UIImage *)leftLine
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/6, 10)];
    view.backgroundColor = self.lineBgColor;//[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (view.frame.size.height-1)/2, [UIScreen mainScreen].bounds.size.width/6-14, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    
    // 圆点
    UIView *point = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame), (view.frame.size.height-4)/2, 4, 4)];
    point.backgroundColor = [UIColor grayColor];
    point.layer.cornerRadius = 2;
    point.layer.masksToBounds = YES;
    [view addSubview:point];
    
    return  [self convertViewToImage:view];
}

- (UIImage *)rightLine
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/6, 10)];
    view.backgroundColor = self.lineBgColor;//[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(14, (view.frame.size.height-1)/2, [UIScreen mainScreen].bounds.size.width/6-14, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    
    // 圆点
    UIView *point = [[UIView alloc]initWithFrame:CGRectMake(10, (view.frame.size.height-4)/2, 4, 4)];
    point.backgroundColor = [UIColor grayColor];
    point.layer.cornerRadius = 2;
    point.layer.masksToBounds = YES;
    [view addSubview:point];
    
    return  [self convertViewToImage:view];
}


//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

@end
