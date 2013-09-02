//
//  fixitTicketTableCell.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/2/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "fixitTicketTableCell.h"

@implementation fixitTicketTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.complexityMeter.unSelectedImage = [UIImage imageNamed:@"Full-Gear.png"];
        self.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
        self.complexityMeter.complexity = 0;
        self.complexityMeter.editable = YES;
        self.complexityMeter.maxComplexity = 8;
        self.complexityMeter.delegate = self;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
