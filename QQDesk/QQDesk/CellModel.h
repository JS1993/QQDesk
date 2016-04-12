//
//  CellModel.h
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    cellTypeFromSelf=0,
    cellTypeFromOthers=1
}CellType;

@interface CellModel : NSObject
@property(copy,nonatomic)NSString* text;
@property(copy,nonatomic)NSString* time;
@property(nonatomic)int type;

+(instancetype)cellModelWithDict:(NSDictionary*)dict;

@end
