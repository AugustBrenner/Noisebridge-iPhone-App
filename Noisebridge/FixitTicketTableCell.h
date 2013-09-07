//
//  fixitTicketTableCell.h
//  Noisebridge
//
//  Created by Ryan Brenner on 9/2/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplexityMeter.h"

@protocol FixitTicketTableCellDelegate <NSObject>
@end
@interface FixitTicketTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ticketTitle;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;

@property (nonatomic, strong) id <FixitTicketTableCellDelegate> delegate;


@end
