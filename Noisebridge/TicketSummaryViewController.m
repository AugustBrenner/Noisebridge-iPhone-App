//
//  TicketSummaryViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/4/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "TicketSummaryViewController.h"
#import "APIHelper.h"

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
    
    _cancelButton.hidden=TRUE;
    _saveButton.hidden=TRUE;
    
    if (![[self.ticketSummary objectForKey:ticketTitleResponse] isKindOfClass:[NSNull class]]){
        self.ticketTitle.text = [self.ticketSummary objectForKey:ticketTitleResponse];
    } else {
        self.ticketTitle.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketDescriptionResponse] isKindOfClass:[NSNull class]]){
        self.ticketDescription.text = [self.ticketSummary objectForKey:ticketDescriptionResponse];
    } else {
        self.ticketDescription.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketCreationDateResponse] isKindOfClass:[NSNull class]]){
        self.dateCreated.text = [self.ticketSummary objectForKey:ticketCreationDateResponse];
    } else {
        self.dateCreated.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketDueDateResponse] isKindOfClass:[NSNull class]]){
        self.dateDue.text = [self.ticketSummary objectForKey:ticketDueDateResponse];
    } else {
        self.dateDue.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketModificationDateResponse] isKindOfClass:[NSNull class]]){
        self.dateModified.text = [self.ticketSummary objectForKey:ticketModificationDateResponse];
    } else {
        self.dateModified.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketTypeResponse] isKindOfClass:[NSNull class]]){
        self.ticketType.text = [self.ticketSummary objectForKey:ticketTypeResponse];
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

- (IBAction)editButton:(id)sender {
    // hide the current button set and reveal the editing buttons
    _editButton.hidden=TRUE;
    _backButton.hidden=TRUE;
    _saveButton.hidden=FALSE;
    _cancelButton.hidden=FALSE;
    
    // change editable for all pertinents variables
}

- (IBAction)cancelButton:(id)sender {
    // hide the editing button set and reveal the main button set
    _editButton.hidden=FALSE;
    _backButton.hidden=FALSE;
    _saveButton.hidden=TRUE;
    _cancelButton.hidden=TRUE;
    
    // resets all editing changes to pre-editing state
}

- (IBAction)saveButton:(id)sender {
    // hide the editing button set and reveal the main button set
    _editButton.hidden=FALSE;
    _backButton.hidden=FALSE;
    _saveButton.hidden=TRUE;
    _cancelButton.hidden=TRUE;
    
    // http request to API to update ticket information
}
@end
