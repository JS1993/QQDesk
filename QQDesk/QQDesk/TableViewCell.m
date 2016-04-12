//
//  TableViewCell.m
//  QQDesk
//
//  Created by  江苏 on 16/4/12.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UIButton* textsButton;
@property(nonatomic,strong)UIImageView* headImageView;

@end

@implementation TableViewCell

+(TableViewCell *)tableViewCellWithTableView:(UITableView *)tableView{
    static NSString* identifier=@"Cell";
    TableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UIButton *)textsButton{
    if (_textsButton==nil) {
        _textsButton=[[UIButton alloc]init];
        _textsButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        _textsButton.titleLabel.font=[UIFont systemFontOfSize:15];
        _textsButton.titleLabel.numberOfLines=0;
        _textsButton.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:_textsButton];
    }
    return _textsButton;
}

-(UIImageView *)headImageView{
    if (_headImageView==nil) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.layer.cornerRadius=25;
        _headImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;
}

-(void)setCellModelF:(CellModelFrame *)cellModelF{
    _cellModelF=cellModelF;
    //设置内容
    [self setContents];
    //设置位置
    [self setFrames];
}

-(void)setContents{
    //设置时间
    self.timeLabel.text=self.cellModelF.cellModel.time;
    
   //设置头像
    if (self.cellModelF.cellModel.type==0) {
        self.headImageView.image=[UIImage imageNamed:@"Gatsby"];
    }else{
        self.headImageView.image=[UIImage imageNamed:@"Jobs"];
    }
    
    //设置消息内容
    [self.textsButton setTitle:self.cellModelF.cellModel.text forState:UIControlStateNormal];
    
}

-(void)setFrames{
    self.headImageView.frame=self.cellModelF.headImageViewF;
    self.timeLabel.frame=self.cellModelF.timeF;
    self.textsButton.frame=self.cellModelF.textF;
}
@end
