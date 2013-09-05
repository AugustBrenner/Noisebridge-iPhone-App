//
//  TicketSummaryViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/4/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "TicketSummaryViewController.h"

@interface TicketSummaryViewController ()

@end

@implementation TicketSummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (![[self.ticketSummary objectForKey:@"title"] isKindOfClass:[NSNull class]]){
        self.ticketTitle.text = [self.ticketSummary objectForKey:@"title"];
    } else {
        self.ticketTitle.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:@"due_at"] isKindOfClass:[NSNull class]]){
        self.ticketDescription.text = [self.ticketSummary objectForKey:@"description"];
    } else {
        self.ticketDescription.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:@"created_at"] isKindOfClass:[NSNull class]]){
        self.dateCreated.text = [self.ticketSummary objectForKey:@"created_at"];
    } else {
        self.dateCreated.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:@"due_at"] isKindOfClass:[NSNull class]]){
        self.dateDue.text = [self.ticketSummary objectForKey:@"due_at"];
    } else {
        self.dateDue.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:@"updated_at"] isKindOfClass:[NSNull class]]){
        self.dateModified.text = [self.ticketSummary objectForKey:@"updated_at"];
    } else {
        self.dateModified.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:@"ticket_type"] isKindOfClass:[NSNull class]]){
        self.ticketType.text = [self.ticketSummary objectForKey:@"ticket_type"];
    } else {
        self.ticketType.text = @"N/A";
    }

    
    /*self.complexityMeter.unSelectedImage = [UIImage imageNamed:@"Full-Gear.png"];
    self.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
    self.complexityMeter.complexity = 8;//[dict objectForKey:@"complexity"];
    self.complexityMeter.editable = NO;
    self.complexityMeter.maxComplexity = 8;
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
