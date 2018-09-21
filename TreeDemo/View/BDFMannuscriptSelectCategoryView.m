//
//  BDFMannuscriptSelectCategoryView.m
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFMannuscriptSelectCategoryView.h"
#import "BDFManuCategoryCell.h"
#import "Node.h"

@interface BDFMannuscriptSelectCategoryView() <UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic)NSMutableArray *Points;
@property (strong,nonatomic)NSMutableArray *allPoints;
@property (nonatomic, assign) BOOL isNeedReloadData;
@property (nonatomic, assign) BOOL is;
@property (nonatomic, strong) NSMutableArray *reloadArray;
@end

@implementation BDFMannuscriptSelectCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = NO;
        self.is = YES;
    }
    return self;
}

-(void)setCateModel:(BDFManuCategoryModel *)cateModel {
    if (cateModel == nil) {
        return;
    }
    _cateModel = cateModel;
    _Points = [NSMutableArray array];
    _allPoints = [NSMutableArray array];
    BOOL isHasNext = NO;
    for (int i = 0; i < cateModel.results.count; i++) {
        BDFManuCategoryResuletModel *obj = cateModel.results[i];
        isHasNext = NO;
        for (int j = 0; j < cateModel.results.count; j++) {
            BDFManuCategoryResuletModel *nextObj = cateModel.results[j];
            if (self.isSubmit) {//提交位置界面要求部分展开，特殊处理
                obj.expand = obj.expand;
                obj.foldCanExist = obj.foldCanExist;
            } else {
                obj.expand = YES;
                obj.foldCanExist = NO;
            }
            if (obj.ID == nextObj.parent_id) {//说明有下级节点
                isHasNext = YES;
                break;
            }
        }
         Node *node = [[Node alloc] initWithParentId:obj.parent_id nodeId:obj.ID name:obj.name depth:0 expand:obj.expand hasNextNode:isHasNext isHide:obj.hide isTrans:obj.trans isOwner:obj.owner isParent:isHasNext andManuType:obj.manuType isChannel:obj.isChannel isCanExist:obj.foldCanExist];
        [_allPoints addObject:node];
    }
    for (int i = 0; i < _allPoints.count; i++) {
        BOOL hasPartent = NO;
        Node *nodei = _allPoints[i];
        for (int j = 0; j < _allPoints.count; j++) {
            Node *nodej = _allPoints[j];
            if (nodei.parentId == nodej.nodeId) {
                hasPartent = YES;
            }
        }
        if (!hasPartent) {
            [self expendNode:nodei depth:0];
        }
    }
    self.data = _Points;
    self.tempData = [self createTempData:_Points];
    if (self.firstNodeCellHand) {
        if (self.tempData.count) {
            Node *node = _tempData.firstObject;
            self.firstNodeCellHand(node.nodeId, node.name);
        }
    }
    [self.reloadArray removeAllObjects];
}

///递归处理各个节点的层级关系
-(void)expendNode:(Node *)rootNode depth:(int)depth {
    
    [_Points addObject:rootNode];
    
    if ([self isHadChildNode:rootNode] <= 0) {
        return;
    }
    
    [self.allPoints enumerateObjectsUsingBlock:^(Node *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.parentId == rootNode.nodeId) {
            obj.depth = depth + 1;
            [self expendNode:obj depth:obj.depth];
        }
    }];
}

///判断是否有子节点
-(NSInteger)isHadChildNode:(Node *)rootNode {
    __block int index = 0;
    
    for (int i = 0; i < self.allPoints.count; i++) {
        
        Node *obj = self.allPoints[i];
        if (obj.parentId == rootNode.nodeId) {
            index ++;
        }
    }
    return index;
}

/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData : (NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<_data.count; i++) {
        Node *node = [data objectAtIndex:i];
        if (node.expand || node.foldCanExist) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDFManuCategoryCell *cell = [[BDFManuCategoryCell alloc] init];
    cell.contentViewWidth = self.frame.size.width;
    Node *node = [_tempData objectAtIndex:indexPath.row];
    cell.node = node;
    cell.clickExpandButtonHand = ^(BOOL isNeeedReloadData){
        self.isNeedReloadData = isNeeedReloadData;
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - Optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BDFManuCategoryCell *cell = [self cellForRowAtIndexPath:indexPath];
    Node *selectNode = [_tempData objectAtIndex:indexPath.row];
    if (self.isNeedReloadData) {
        if (self.is) {
//            [UIView animateWithDuration:0.1 animations:^{
//                cell.expandButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//            }];
            self.is = NO;
        }else {
//            [UIView animateWithDuration:0.1 animations:^{
//                cell.expandButton.imageView.transform = CGAffineTransformIdentity;
//            }];
            self.is = YES;
        }
        selectNode.expand = !selectNode.expand;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.reloadArray removeAllObjects];
        
        if (selectNode.expand) {
            [self expandNodesForParentID:selectNode.nodeId insertIndex:indexPath.row];
            [tableView insertRowsAtIndexPaths:self.reloadArray withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [self foldNodesForLevel:selectNode.depth currentIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:self.reloadArray withRowAnimation:UITableViewRowAnimationNone];
        }
        if (self.expandNodeBlock) {
            self.expandNodeBlock(self.tempData, indexPath.row, selectNode.expand);
        }
    } else {
        //执行block刷新数据
        if (self.didSelectCellHand) {
            Node *node = self.tempData[indexPath.row];
            if (self.isSubmit) {
                //获取到记录历史位置的字符串
                NSString *nodeStr = [self stringFromNode:node];
                node.historyStr = nodeStr;
            }
            self.didSelectCellHand(node);
        }
    }
}

- (void)foldNodesForLevel:(int)level currentIndex:(NSUInteger)currentIndex{
    
    if (currentIndex+1<self.tempData.count) {
        NSMutableArray *tempArr = [self.tempData copy];//此处新建数组是为了不更改_tempData的数据
        for (NSUInteger i = currentIndex+1 ; i<tempArr.count;i++) {
            Node *node = tempArr[i];
            if (node.depth <= level) {
                break;
            }else{
                [self.tempData removeObject:node];
                [self.reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];//need reload nodes
            }
        }
    }
}

- (NSUInteger)expandNodesForParentID:(NSInteger)parentID insertIndex:(NSUInteger)insertIndex{
    
    for (int i = 0 ; i<self.data.count;i++) {
        Node *node = self.data[i];
        if (node.parentId == parentID) {
                node.expand = NO;
            insertIndex++;
            [self.tempData insertObject:node atIndex:insertIndex];
            [self.reloadArray addObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]];//need reload nodes
            if (node.expand) {
                insertIndex = [self expandNodesForParentID:node.nodeId insertIndex:insertIndex];
            }
        }
    }
    
    return insertIndex;
}


/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (Node *)parentNode{
    NSUInteger startPosition = [self.tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i = startPosition + 1; i < self.tempData.count; i++) {
        Node *node = [self.tempData objectAtIndex:i];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == self.tempData.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [self.tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

- (NSString *)stringFromNode:(Node *)node {
    Node *nodeSelect = node;
    NSMutableArray *nodeArray = [NSMutableArray array];
    [nodeArray addObject:nodeSelect];
    while (nodeSelect.depth >= 1) {
        for (Node *parentNode in self.data) {
            if (nodeSelect.parentId == parentNode.nodeId) {
                nodeSelect = parentNode;
                [nodeArray addObject:parentNode];
            }
        }
    }
    
    NSMutableArray *nodeNameArray = [NSMutableArray array];
    for (int i = 0; i < nodeArray.count; i++) {
        Node *nodeAdd = nodeArray[i];
        [nodeNameArray addObject:nodeAdd.name];
    }
    nodeNameArray = (NSMutableArray *)[[nodeNameArray reverseObjectEnumerator] allObjects];
    NSString *nodeStr = [nodeNameArray componentsJoinedByString:@"-"];
    return nodeStr;
}

- (NSArray *)data {
    if (!_data) {
        _data = [NSArray array];
    }
    return _data;
}

- (NSMutableArray *)tempData {
    if (!_tempData) {
        _tempData = [NSMutableArray array];
    }
    return _tempData;
}

- (NSMutableArray *)reloadArray {
    if (!_reloadArray) {
        _reloadArray = [NSMutableArray array];
    }
    return _reloadArray;
}

-(void)dealloc {
    NSLog(@"%s",__func__);
}

@end

