//
//  TicketSummaryViewController.h
//  Noisebridge
//
//  Created by Ryan Brenner on 9/4/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplexityMeter.h"

@interface TicketSummaryViewController : UIViewController <ComplexityMeterDelegate>

@property (strong, nonatomic) NSDictionary *ticketSummary;

@property (weak, nonatomic) IBOutlet UITextField *dateCreated;
@property (weak, nonatomic) IBOutlet UITextView *ticketDescription;
@property (weak, nonatomic) IBOutlet UITextField *dateDue;
@property (weak, nonatomic) IBOutlet UITextField *ticketTitle;
@property (weak, nonatomic) IBOutlet UITextField *dateModified;
@property (weak, nonatomic) IBOutlet ComplexityMeter *complexityMeter;
@property (weak, nonatomic) IBOutlet UITextField *ticketType;

@end
