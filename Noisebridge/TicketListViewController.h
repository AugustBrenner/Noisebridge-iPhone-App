//
//  TicketListViewController.h
//  Noisebridge
//
//  Created by Ryan Brenner on 9/3/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FixitTicketTableCell.h"

@interface TicketListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FixitTicketTableCellDelegate>{
IBOutlet UITableView* ticketTable;
}

@property (nonatomic, retain) UITableView* ticketTable;
@property (strong, nonatomic) NSArray *ticketArray;
@property (strong, nonatomic) NSDateFormatter *dateFormat;

@end
