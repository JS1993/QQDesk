//
//  ViewController.m
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "CellModelFrame.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray* cellModelFrame;
@end

@implementation ViewController
-(NSMutableArray *)cellModelFrame{
    if (_cellModelFrame==nil) {
        _cellModelFrame=[CellModelFrame cellModelFrames];
    }
    return _cellModelFrame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark-tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellModelFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell* cell=[TableViewCell tableViewCellWithTableView:tableView];
    cell.cellModelF=self.cellModelFrame[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cellModelFrame[indexPath.row] cellHight];
}
@end
