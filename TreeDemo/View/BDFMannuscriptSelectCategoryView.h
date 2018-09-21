//
//  BDFMannuscriptSelectCategoryView.h
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFBaseTableView.h"
#import "BDFManuCategoryModel.h"

@class Node;

@interface BDFMannuscriptSelectCategoryView : BDFBaseTableView

@property (nonatomic, strong) BDFManuCategoryModel *cateModel;

@property (nonatomic, strong) NSArray *data;//传递过来已经组织好的数据（全量数据）

@property (nonatomic, strong) NSMutableArray *tempData;//用于存储数据源（部分数据）

@property (nonatomic, copy) void (^didSelectCellHand) (Node *node);

@property (nonatomic, copy) void (^firstNodeCellHand) (NSInteger nodeId, NSString *name);

@property (nonatomic, copy) void (^expandNodeBlock) (NSArray *tempArray, NSInteger index, BOOL expand);

///此处对提交位置界面进行特殊处理，此页面部分展开，特此说明
@property (nonatomic, assign) BOOL isSubmit;

@end

