//
//  BDFCustomBlurView.m
//  BDFMobileCollect
//
//  Created by zsy on 2017/7/25.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFCustomBlurView.h"

@implementation BDFCustomBlurView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self addSubview:effectView];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.rightTableViewHand) {
        self.rightTableViewHand();
    }
}

@end
