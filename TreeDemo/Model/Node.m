//
//  Node.m
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand hasNextNode:(BOOL)hasNext isHide:(BOOL)ishide isTrans:(BOOL)istrans isOwner:(BOOL)isowner isParent:(BOOL)isParent andManuType:(AllKindsOfManuLibType)manuType isChannel:(NSString*)isChannel isCanExist:(BOOL)canExist {
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
        self.depth = depth;
        self.expand = expand;
        self.hasNextNode = hasNext;
        self.hide = ishide;
        self.trans = istrans;
        self.owner = isowner;
        self.isParent = isParent;
        self.manuType = manuType;
        self.isChannel = isChannel; //只有翔宇用到
        self.foldCanExist = canExist;//expand为NO也可展示
    }
    return self;
}
- (instancetype)initWithParentId : (NSInteger)parentId nodeId : (NSInteger)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand hasNextNode : (BOOL)hasNext isParent:(BOOL)isParent isTrans : (BOOL)istrans andManuType:(AllKindsOfManuLibType)manuType isChannel:(NSString*)isChannel{
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
        self.depth = depth;
        self.expand = expand;
        self.hasNextNode = hasNext;
        self.isParent = isParent;
        self.trans = istrans;
        self.manuType = manuType;
        self.isChannel = isChannel;

    }
    return self;
}
@end
