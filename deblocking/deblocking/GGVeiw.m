//
//  GGVeiw.m
//  九宫格解锁
//
//  Created by 高恒伟521 on 15/11/18.
//  Copyright © 2015年 gds. All rights reserved.
//
#define Kcount 9
#import "GGVeiw.h"

@interface GGVeiw  ()
//定义按钮来记录被选中的按钮
@property(nonatomic,strong)NSMutableArray *buttons;
//记录手指所在的位置
@property(nonatomic,assign)CGPoint currentPoint;



@end


@implementation GGVeiw

- (NSMutableArray *)buttons{
    
    if (_buttons ==nil ) {
        
        _buttons = [NSMutableArray arrayWithCapacity:10];
    }
    
    
    return _buttons;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if ([super initWithCoder:aDecoder]) {
        for (int i =0 ; i <9 ; i ++) {
            //创建按钮
            UIButton *btn = [[UIButton alloc]init];
            
            [self addSubview:btn];
            
            //设置frame
            //设置背景图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            //设置禁用状态下的图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            btn.userInteractionEnabled =NO;
            
            btn.tag =i;
            
        }
        
        
        
    }
    
  
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    int colCount = 3;
    CGFloat w =77;
    CGFloat h =w;
    //子view的横向间距  =  (父view的宽度- 3 * 子view的宽度) / 4
    CGFloat marginX = (self.bounds.size.width - colCount * w)/(colCount +1);
    CGFloat marginY =(self.bounds.size.width - colCount *h)/(colCount +1);
    for ( int i =0; i <Kcount; i++) {
        
          int col = i/colCount ;
        int row = i %colCount ;
//        子view横坐标的公式 =  子view的横向间距  +  列号 * (子view的横向间距+ 子view的宽度)
 //        子view纵坐标的公式 = 50 + 行号 * (子view的纵向间距+ 子view的高度)
        
        CGFloat x = marginX + col * (marginX + w);
        CGFloat y = marginY +row * (marginY +h);
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
        
        
        
        
    }
    
    
    
  
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前位置
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:touch.view];
    //判断当前位置是不是在按钮上
    for (UIButton *btn  in self.subviews) {
        
        if (CGRectContainsPoint(btn.frame, point) && ! btn.selected) {
            
            
            btn.selected =YES;
            //定义属性来记录被选中的按钮
            [self.buttons addObject:btn];
     
        }
   
    }
 
}

//和开始点击做的事情一样
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesBegan:touches withEvent:event];
    //获取当前点的坐标进行连线
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //记录当前点
    self.currentPoint = point;
    
    
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.currentPoint =CGPointZero;
    
    [self setNeedsDisplay];
    
    
    if ([self.delegate respondsToSelector:@selector(viewtouchEnd:)]) {
        
        [self.delegate viewtouchEnd:self];
    
    }
    
    NSString *str =@"012";
    NSMutableString *mtstr = [NSMutableString string];
    for (UIButton *btn in self.buttons) {
        
        [ mtstr appendFormat:@"%zd",btn.tag ];
      
    }
    if ([str isEqualToString:mtstr]) {
        NSLog(@"正确");
    }else{
        
        //错误的时候把按钮变为禁用
        for (UIButton *btn  in self.buttons) {
            
            [btn setEnabled:NO];
            //把选中状态去掉
            [btn setSelected:NO];
            
            
        }
        
        
        
    }
    self.userInteractionEnabled =NO;
    //清空按钮的状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.userInteractionEnabled = YES;
        for (UIButton *btn in self.buttons) {
            
            // 设置不选中
            [btn setSelected:NO];
            //设置不禁用
            [btn setEnabled:YES];
            
            
        }
        
        [self.buttons removeAllObjects];
        [self setNeedsDisplay];
        
        
        
        
    });
    
    
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //取出按钮进行连线
    for (int i = 0; i <self.buttons.count; i ++) {
        UIButton *btn = self.buttons[i];
        
        //如果是第一个点的话就设置为起点
        if (i == 0) {
            
            [path moveToPoint:btn.center];
            
        }else{
            
            [path addLineToPoint:btn.center];
            
        }

    }
    if (!CGPointEqualToPoint(self.currentPoint, CGPointZero)) {
        [path addLineToPoint:self.currentPoint];
    }
    
    
    
    [path setLineWidth:5];
    [[UIColor whiteColor] setStroke];
    
    [path stroke];
    

    
    
    
    
}


@end
