//
//  fixitTicketTableCell.h
//  Noisebridge
//
//  Created by Ryan Brenner on 9/2/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplexityMeter.h"

@interface fixitTicketTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ComplexityMeter *complexityMeter;
@property (weak, nonatomic) IBOutlet UILabel *ticketTitle;

@end
