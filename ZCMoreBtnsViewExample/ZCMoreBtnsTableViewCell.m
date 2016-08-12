//
//  OraMoreBtnsTableViewCell.m
//  test
//
//  Created by zhangcheng on 16/6/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMoreBtnsTableViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation ZCMoreBtnsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildSubviews];
    }
    return self;
}
-(void)buildSubviews
{
    self.selectedImg=[[UIImageView alloc]init];
    self.selectedImg.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.selectedImg];
    //
    self.contentImg=[[UIImageView alloc]init];
    self.contentImg.backgroundColor=[UIColor redColor];
    [self addSubview:self.contentImg];
    //
    self.contentLabel=[[UILabel alloc]init];
    self.contentLabel.backgroundColor=[UIColor clearColor];
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    self.contentLabel.textColor=[UIColor whiteColor];
    [self.contentLabel sizeToFit];
    [self addSubview:self.contentLabel];
    //
}
- (void)layoutSubviews {
    @weakify(self);
    
    [self.selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(4));
    }];
    //
    [self.contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.selectedImg.mas_right).offset(16);
        make.top.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-2);
        make.width.mas_equalTo(@(36));
    }];
    //
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentImg.mas_right).offset(6);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
    }];
       [super layoutSubviews];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
