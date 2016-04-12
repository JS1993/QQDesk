//
//  CellModelFrame.m
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "CellModelFrame.h"

@implementation CellModelFrame

-(void)setCellModel:(CellModel *)cellModel{
    
    _cellModel=cellModel;
    
    CGFloat padding=10;
    CGFloat screenWidth=[[UIScreen mainScreen] bounds].size.width;
    //设置时间位置
    _timeF=CGRectMake(0, 0, screenWidth, 44);
    //设置头像
    if (self.cellModel.type==1) {
        _headImageViewF=CGRectMake(padding, CGRectGetMaxY(self.timeF), 50, 50);
    }else{
        _headImageViewF=CGRectMake(screenWidth-50, CGRectGetMaxY(self.timeF), 50, 50);
    }
    //设置正文
    CGRect textRect=[self.cellModel.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    if (self.cellModel.type==1) {
        textRect.origin.x=CGRectGetMaxX(self.headImageViewF)+padding;
        textRect.origin.y=CGRectGetMaxY(self.timeF);
    }else{
        textRect.origin.x=screenWidth-padding-50-textRect.size.width;
        textRect.origin.y=CGRectGetMaxY(self.timeF);
    }
    _textF=textRect;
    
    //得到行高
    _cellHight=MAX(CGRectGetMaxY(self.headImageViewF), CGRectGetMaxY(self.textF));
}


+(NSMutableArray*)cellModelFrames{
    NSMutableArray* arrM=[NSMutableArray array];
    NSArray* arr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    for (NSDictionary* dic in arr ) {
        CellModelFrame* cellModelFrame=[[CellModelFrame alloc]init];
        cellModelFrame.cellModel=[CellModel cellModelWithDict:dic];
        [arrM addObject:cellModelFrame];
    }
    return arrM;
}

@end
