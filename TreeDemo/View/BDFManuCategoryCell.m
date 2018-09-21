//
//  BDFManuCategoryCell.m
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFManuCategoryCell.h"
#import "UIView+Tap.h"

@interface BDFManuCategoryCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UILabel *lineLabel;

@property (nonatomic, weak) UILabel *leftLabel;



@property (nonatomic, assign) BOOL open;

@end

@implementation BDFManuCategoryCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.contentView addGestureRecognizer:singleTap];
        //这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
    }
    return self;
}

-(void)setNode:(Node *)node {
    if (node == nil) {
        return;
    }
    _node = node;
//    BDFLog(@"node.depth:%d  node.name:%@ node.expand:%d",self.node.depth, self.node.name, self.node.expand);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.indentationLevel = node.depth; // 缩进级别
    self.indentationWidth = 20.f; // 每个缩进级别的距离
    CGFloat nameLabelX = self.indentationWidth * self.indentationLevel + 20;
    self.nameLabel.frame = CGRectMake(nameLabelX, 0, self.contentViewWidth - nameLabelX - 29, self.height);
    self.nameLabel.text = [NSString stringWithFormat:@"  %@",node.name];
    for (int i = 0; i < self.node.depth; i++) {
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.indentationWidth * (i + 1), 0, 0.5, self.height)];
        lineImageView.image = [UIImage imageNamed:@"category_line"];
        [self.contentView addSubview:lineImageView];
    }
    if (self.node.hasNextNode) {
        self.leftLabel.origin = CGPointMake(0, (self.contentView.height - self.leftLabel.height) / 2.);
        self.nameLabel.backgroundColor = UIColorFromRGB(0xf9f9f9);
        self.nameLabel.layer.cornerRadius  = 5;
        if (self.node.expand) {
            self.rightImage.image = [UIImage imageNamed:@"home_categoryarrowblow"];
        } else {
            self.rightImage.image = [UIImage imageNamed:@"home_categoryarrow"];
        }
        self.rightImage.frame = CGRectMake(self.contentViewWidth - 30, (self.height - 30) / 2., 30, 30);
    }else {
        // 不处理
    }
}

-(UILabel *)leftLabel {
    if (!_leftLabel) {
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.backgroundColor = KMainGreenColor;
        leftLabel.size = CGSizeMake(5, 10);
        [self.nameLabel addSubview:leftLabel];
        _leftLabel = leftLabel;
    }
    return _leftLabel;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        _nameLabel  = nameLabel;
    }
    return _nameLabel;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImage];
    }
    return _rightImage;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.contentView];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    BOOL isNeedReloadData = CGRectContainsPoint(self.rightImage.frame, point);
    if (self.clickExpandButtonHand) {
        self.clickExpandButtonHand(isNeedReloadData);
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
