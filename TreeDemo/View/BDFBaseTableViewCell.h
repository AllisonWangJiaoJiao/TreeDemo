//
//  BDFBaseTableViewCell.h
//  BDFMobileCollect
//
//  Created by zsy on 2017/1/9.
//  Copyright © 2017年 allison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDFBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *tableView;

/**
 *  快速创建一个不是从Xib加载的cell
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

+(instancetype)nibWithTableView:(UITableView *)tableView;

@end
