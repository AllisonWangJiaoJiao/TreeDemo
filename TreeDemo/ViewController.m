//
//  ViewController.m
//  TreeDemo
//
//  Created by allison on 2018/9/3.
//  Copyright © 2018年 allison. All rights reserved.
//

#import "ViewController.h"
#import "BDFMannuscriptSelectCategoryView.h"
#import "Node.h"
#import "BDFCustomBlurView.h"
#import "YYModel.h"
#import "BDFManuCategoryModel.h"

@interface ViewController ()
@property (nonatomic, weak) BDFMannuscriptSelectCategoryView *categoryView;
@property (nonatomic, strong) BDFCustomBlurView *blurView;
@property (nonatomic, assign) NSInteger categoryID;
@property (nonatomic, assign) NSInteger firstCategoryID;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic,strong) NSArray *dataSOurce;
@property (nonatomic, strong) NSMutableArray <BDFManuCategoryResuletModel *> *xhsCategoryArray;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@end

@implementation ViewController

- (NSMutableArray *)xhsCategoryArray {
    if (!_xhsCategoryArray) {
        _xhsCategoryArray = [NSMutableArray array];
    }
    return _xhsCategoryArray;
}

-(BDFCustomBlurView *)blurView {
    if (_blurView == nil) {
        WeakSelf(weakSelf);
        BDFCustomBlurView *blurView = [[BDFCustomBlurView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        blurView.rightTableViewHand = ^{
            [weakSelf setScreenRightView];
        };
        _blurView = blurView;
    }
    return _blurView;
}

-(BDFMannuscriptSelectCategoryView *)categoryView {
    if (!_categoryView) {
        WeakSelf(weakSelf)
        BDFMannuscriptSelectCategoryView *categoryView = [[BDFMannuscriptSelectCategoryView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH * 0.8, 64, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT - 20)];
        categoryView.backgroundColor = [UIColor whiteColor];
        categoryView.didSelectCellHand = ^(Node *node) {
            if (node.hide) {
                NSLog(@"当前节点无可浏览权限！");
            } else {
                weakSelf.defaultLabel.text = node.name;
                weakSelf.blurView.rightTableViewHand();
                weakSelf.categoryID = node.nodeId;
                //  [weakSelf loadData];
            }
        };
        //获取列表的第一个ID
        categoryView.firstNodeCellHand = ^(NSInteger nodeId, NSString *name) {
            weakSelf.firstCategoryID = nodeId;
            weakSelf.title = name;
            // [weakSelf loadData];
        };
        [weakSelf.blurView addSubview:categoryView];
        _categoryView = categoryView;
    }
    return _categoryView;
}

-(void)setScreenRightView {
    
    if (self.categoryView.x == 0) {
        [UIView animateWithDuration:0.22 animations:^{
            self.categoryView.x = -SCREEN_WIDTH * 0.8;
            self.rightButton.x = 0;
        } completion:^(BOOL finished) {
            self.categoryView.hidden = YES;
            self.rightButton.x = 0;
            [self.blurView removeFromSuperview];
        }];
    }else {
        [self.view addSubview:self.blurView];
        [UIView animateWithDuration:0.22 animations:^{
            self.categoryView.hidden = NO;
            self.categoryView.x = 0;
            self.rightButton.x = self.categoryView.right;
        }];
    }
}
-(UIButton *)rightButton {
    if (!_rightButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.7, CategoryButtonW, CategoryButtonH)];
        // [button setBackgroundColor:kBlueColor];
        [button setBackgroundImage:[UIImage imageNamed:@"rightButton"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(setScreenRightView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _rightButton = button;
    }
    return _rightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //侧边栏控制器
    self.rightButton.hidden = NO;
    [self loadCategoryData];

}

-(void)loadCategoryData {
    
    NSDictionary *dic = [self readLocalFileWithName:@"manu"];
    BDFManuCategoryModel *cateModel = [BDFManuCategoryModel yy_modelWithDictionary:dic] ;
    self.categoryView.cateModel = cateModel;
    [self.categoryView reloadData];
}

- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
