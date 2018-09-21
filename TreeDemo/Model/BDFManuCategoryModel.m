//
//  BDFManuCategoryModel.m
//  BDFMobileCollect
//
//  Created by zsy on 2017/6/7.
//  Copyright © 2017年 allison. All rights reserved.
//

#import "BDFManuCategoryModel.h"

@implementation BDFManuCategoryModel

+ (NSDictionary *)modelContainerPropertyGenericClass {

    return @{@"results" :[BDFManuCategoryResuletModel class] };
}

@end

@implementation BDFManuCategoryResuletModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"ID":@"id"};
}

@end
