//
//  BDFManuCategoryModel.h
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDFManuCategoryResuletModel;

@interface BDFManuCategoryModel : NSObject

@property (nonatomic, strong) NSMutableArray <BDFManuCategoryResuletModel *> *results;

@property (nonatomic, assign) BOOL success;

@end

@interface BDFManuCategoryResuletModel : NSObject

@property (nonatomic, assign) NSInteger parent_id;/*parent_id*/

@property (nonatomic, assign) NSInteger ID; /*ID*/

@property (nonatomic, assign) BOOL hide; /*hide*/

@property (nonatomic, strong) NSString *name;/*name*/

@property (nonatomic, assign) BOOL trans;/*trans*/

@property (nonatomic, assign) BOOL folder;/*folder*/

@property (nonatomic, assign) BOOL owner;
//翔宇的属性
@property (nonatomic, assign) BOOL isParent;

@property (nonatomic, assign) BOOL isXY;

@property (nonatomic, assign) int channel;

@property (nonatomic, strong) NSString *isChannel;

@property (nonatomic, assign) AllKindsOfManuLibType manuType;

@property (nonatomic, strong) NSString *docName;

@property (nonatomic, assign) NSInteger docLibID;

@property (nonatomic, strong) NSString *docType;

@property (nonatomic, assign) BOOL expand;

@property (nonatomic, assign) int depth;//该节点的深度

@property (nonatomic, assign) BOOL foldCanExist;//expand为NO也可展示

@property (nonatomic, assign) BOOL isRootNode;//前端添加判断根节点参数
///区分稿件类型text,image,video等
@property (nonatomic, strong) NSString *typeString;
///目前用于区分草稿箱和已退稿的上传历史位置和投稿，投图，投视频区分开
//@property (nonatomic, assign) BDFManuscriptType manuscriptType;
///Cell添加选中效果
@property (nonatomic, assign) BOOL isMarkColor;

///待发布
@property (nonatomic, assign) BOOL canWillPublish;
///预发布
@property (nonatomic, assign) BOOL canPrePublish;
///发布
@property (nonatomic, assign) BOOL canPublish;

@end
