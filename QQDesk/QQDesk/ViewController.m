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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageTF;
@property(strong,nonatomic)NSMutableArray* cellModelFrame;
@property(strong,nonatomic)NSDictionary* autoReplay;
@end

@implementation ViewController

-(NSDictionary *)autoReplay{
    if (_autoReplay==nil) {
        _autoReplay=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"autoReplay" ofType:@"plist"]];
    }
    return _autoReplay;
}
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

#pragma mark-textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendMessage:textField];
    
    //清空输入框
    self.messageTF.text=@"";
    
    return YES;
}

 static int i=0;
-(void)sendMessage:(UITextField*)textField{
    //自己发送
    CellModel* cellModelx=[[CellModel alloc]init];
    cellModelx.time=[NSString stringWithFormat:@"20:%02d",i++];
    cellModelx.text=self.messageTF.text;
    cellModelx.type=0;
    CellModelFrame* cellModelFx=[[CellModelFrame alloc]init];
    cellModelFx.cellModel=cellModelx;
    [self.cellModelFrame addObject:cellModelFx];
    [self updateTableView];
    //模拟自动回复
    [self setAutoReplayx:self.messageTF.text];
    
}
//自动回复
-(void)setAutoReplayx:(NSString*)str{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CellModel* cellModel=[[CellModel alloc]init];
        cellModel.time=[NSString stringWithFormat:@"20:%02d",i++];
        cellModel.type=1;
        for (int a=0; a<str.length; a++) {
            NSString *subString=[str substringWithRange:NSMakeRange(a, 1)];
            if (self.autoReplay[subString]) {
                cellModel.text=self.autoReplay[subString];
            }else{
                cellModel.text=@"屌炸天";
            }
        }
        CellModelFrame* cellModelF=[[CellModelFrame alloc]init];
        cellModelF.cellModel=cellModel;
        [self.cellModelFrame addObject:cellModelF];
        [self updateTableView];
    });
}
//更新界面
-(void)updateTableView{
    NSIndexPath* path=[NSIndexPath indexPathForRow:self.cellModelFrame.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)dealloc{
    
}
@end
