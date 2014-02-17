//
//  HUMainTableViewCell.m
//  HookUp
//
//  Created by Marcus Mattsson on 16/2/14.
//  Copyright (c) 2014 bitesize. All rights reserved.
//

#import "HUMainTableViewCell.h"

@implementation HUMainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.titleLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = [UIColor redColor];
}

+ (NSString *)identifier {
    return @"CellIdentifier";
}

@end
