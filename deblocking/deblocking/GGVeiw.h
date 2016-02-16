//
//  GGVeiw.h
//  九宫格解锁
//
//  Created by 高恒伟521 on 15/11/18.
//  Copyright © 2015年 gds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGVeiw;

@protocol GGVeiwdelegate <NSObject>

- (void)viewtouchEnd:(GGVeiw *)view;

@end

@interface GGVeiw : UIView

@property(nonatomic,weak)id <GGVeiwdelegate>delegate;

@end
