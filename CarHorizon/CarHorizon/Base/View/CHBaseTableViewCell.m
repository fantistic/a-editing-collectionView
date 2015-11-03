//
//  CHBaseTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/13.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"

@implementation CHBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        
      
        
    }
    return self;
}

-(void)createView{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}


@end
