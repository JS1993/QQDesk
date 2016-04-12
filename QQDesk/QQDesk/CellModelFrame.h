//
//  CellModelFrame.h
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellModel.h"
@interface CellModelFrame : NSObject
@property(nonatomic,assign)CGRect textF;
@property(nonatomic,assign)CGRect timeF;
@property(nonatomic,assign)CGRect headImageViewF;
@property(nonatomic)CGFloat cellHight;

@property(nonatomic,strong)CellModel* cellModel;

+(NSMutableArray*)cellModelFrames;

@end
