//
//  FixitViewController.h
//  Noisebridge
//
//  Created by Ryan Brenner on 8/29/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplexityMeter.h"

@interface FixitViewController : UIViewController <ComplexityMeterDelegate>

@property (weak, nonatomic) IBOutlet ComplexityMeter *complexityMeter;
@property (weak, nonatomic) IBOutlet UITextField *ticketTitle;
@property (weak, nonatomic) IBOutlet UITextView *ticketDescription;

- (IBAction)SubmitFixit:(id)sender;
- (IBAction)ClearButton:(id)sender;

@end
