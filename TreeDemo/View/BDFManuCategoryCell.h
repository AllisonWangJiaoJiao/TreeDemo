//
//  BDFManuCategoryCell.h
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFBaseTableViewCell.h"
#import "BDFManuCategoryModel.h"
#import "Node.h"

@interface BDFManuCategoryCell : BDFBaseTableViewCell

@property (nonatomic, strong) Node *node;

@property (nonatomic, copy) void (^clickExpandButtonHand)(BOOL isNeedReloadData);

@property (nonatomic, assign) CGFloat contentViewWidth;

@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, weak) UILabel *nameLabel;

@end
