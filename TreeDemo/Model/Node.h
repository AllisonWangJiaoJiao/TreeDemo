//
//  Node.h
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  每个节点类型
 */
@interface Node : NSObject

@property (nonatomic , assign) NSInteger parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) NSInteger nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@property (nonatomic , assign) BOOL hasNextNode;//该节点是否有下级节点

@property (nonatomic, assign) BOOL hide;//浏览权限

@property (nonatomic, assign) BOOL trans;//传入权限

@property (nonatomic, assign) BOOL owner;//选用权限

@property (nonatomic, assign) BOOL isParent;//

@property (nonatomic, assign) AllKindsOfManuLibType  manuType;

@property (nonatomic, strong) NSString *isChannel;   //翔宇用的    区分web app发布库

@property (nonatomic, assign) BOOL foldCanExist;//expand为NO也可展示

@property (nonatomic, copy) NSString *historyStr;

@property (nonatomic, assign)BOOL isSelect; //新加属性 判断当前cell按钮是否是选中状态 zhang add
/**
 *快速实例化该对象模型
 */
- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand hasNextNode : (BOOL)hasNext isHide : (BOOL)ishide isTrans : (BOOL)istrans isOwner : (BOOL)isowner isParent:(BOOL)isParent andManuType:(AllKindsOfManuLibType)manuType isChannel:(NSString*)isChannel isCanExist : (BOOL)canExist;

- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand hasNextNode : (BOOL)hasNext isParent:(BOOL)isParent isTrans : (BOOL)istrans andManuType:(AllKindsOfManuLibType)manuType isChannel:(NSString*)isChannel;
@end
