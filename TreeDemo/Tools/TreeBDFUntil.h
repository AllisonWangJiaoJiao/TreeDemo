//
//  TreeBDFUntil.h
//  TreeDemo
//
//  Created by allison on 2018/9/3.
//  Copyright © 2018年 allison. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 代表稿件的---提交位置的所选的部门类型
typedef NS_ENUM(NSInteger, AllKindsOfManuLibType) {
    ///稿源中心
    ManuLibTypeWithManuCenter,
    ///部门库
    ManuLibTypeWithManuDept,
    ///工作组
    ManuLibTypeWithTeamLib,
    ///翔宇
    ManuLibTypeWithXY,
    ///草稿箱
    ManuLibTypeWithPersonal,
};

@interface TreeBDFUntil : NSObject

@end
