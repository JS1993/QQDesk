//
//  TableViewCell.h
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModelFrame.h"
@interface TableViewCell : UITableViewCell

@property(nonatomic,strong)CellModelFrame* cellModelF;

+(TableViewCell*)tableViewCellWithTableView:(UITableView*)tableView;
@end
