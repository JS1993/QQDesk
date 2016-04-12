//
//  CellModel.m
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)cellModelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}

@end
