//
//  ViewController.m
//  九宫格解锁
//
//  Created by 高恒伟521 on 15/11/18.
//  Copyright © 2015年 gds. All rights reserved.
//

#import "ViewController.h"
#import "GGVeiw.h"
@interface ViewController ()<GGVeiwdelegate>
@property (weak, nonatomic) IBOutlet GGVeiw *myView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myView.delegate =self;
    
  
}
- (void)viewtouchEnd:(GGVeiw *)view{
    //截屏
    //创建上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取图片
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    [view.layer renderInContext:ctx];
    
    
   UIImage *img =  UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //保存到相册
//    UIImageWriteToSavedPhotosAlbum(img, nil, nil, NULL);
    //缩放
    
    //创建上下文
    CGFloat scale =0.2;
    CGFloat width =img.size.width *scale;
    CGFloat height = img.size.height *scale;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0);
    
    [img drawInRect:CGRectMake(0 , 0, width, height)];
    //从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.imageView.image = newImage;
    
    
    
    
    
    
}


@end
