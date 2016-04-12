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
    self.tableView.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
/**
 *  键盘通知
 */
-(void)keyboardDidChangeFrame:(NSNotification*)noti{
    [UIApplication sharedApplication].keyWindow.backgroundColor=self.tableView.backgroundColor;
    CGRect frame=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat durationTime=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:durationTime animations:^{
        //设置view的新frame
        self.view.transform=CGAffineTransformMakeTranslation(0, frame.origin.y-[UIScreen mainScreen].bounds.size.height);
    }];
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

#pragma mark-tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cellModelFrame[indexPath.row] cellHight];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)dealloc{
    
}
@end
