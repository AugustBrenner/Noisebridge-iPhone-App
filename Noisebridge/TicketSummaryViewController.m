//
//  TicketSummaryViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/4/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "TicketSummaryViewController.h"
#import "APIHelper.h"
#import <QuartzCore/QuartzCore.h>

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
    
    // hide buttons pertinent to editing
    self.cancelButton.hidden=TRUE;
    self.saveButton.hidden=TRUE;
    
    // styling for text view
    self.ticketDescription.layer.cornerRadius = 3;
    
    // creates a date formatter for formatting the dates from the API
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    
    // complexity meter setup
    self.complexityMeter.unSelectedImage = [UIImage imageNamed:@"Clear-Gear.png"];
    self.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
    self.complexityMeter.complexity = 0;
    self.complexityMeter.maxComplexity = 8;
    self.complexityMeter.delegate = self;
    
    [self populateTable];
    [self isEditing:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)populateTable {
    // displays all criteria from the dictionaries in the array
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
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:[self.dateFormat dateFromString:[self.ticketSummary objectForKey:ticketCreationDateResponse]]];
        
        self.dateCreated.text = [NSString stringWithFormat:@"%d/%d", [components day], [components month]];
    } else {
        self.dateCreated.text = @"N/A";
    }
    
    if (![[self.ticketSummary objectForKey:ticketDueDateResponse] isKindOfClass:[NSNull class]]){
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:[self.dateFormat dateFromString:[self.ticketSummary objectForKey:ticketDueDateResponse]]];
        self.dateDue.text = [NSString stringWithFormat:@"%d/%d", [components day], [components month]];
    } else {
        self.dateDue.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketModificationDateResponse] isKindOfClass:[NSNull class]]){
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:[self.dateFormat dateFromString:[self.ticketSummary objectForKey:ticketModificationDateResponse]]];
        self.dateModified.text = [NSString stringWithFormat:@"%d/%d", [components day], [components month]];
    } else {
        self.dateModified.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketTypeResponse] isKindOfClass:[NSNull class]]){
        self.ticketType.text = [self.ticketSummary objectForKey:ticketTypeResponse];
    } else {
        self.ticketType.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketIDResponse] isKindOfClass:[NSNull class]]){
        self.ticketID.text = [[self.ticketSummary objectForKey:ticketIDResponse] stringValue];
    } else {
        self.ticketID.text = @"N/A";
    }
    if (![[self.ticketSummary objectForKey:ticketOwnerResponse] isKindOfClass:[NSNull class]]){
        self.ticketOwner.text = [[self.ticketSummary objectForKey:ticketOwnerResponse] stringValue];
    } else {
        self.ticketOwner.text = @"Anonymous";
    }
    if (![[self.ticketSummary objectForKey:ticketComplexityResponse] isKindOfClass:[NSNull class]]){
        self.complexityMeter.complexity = [[self.ticketSummary objectForKey:ticketComplexityResponse] integerValue];
    }
}

-(void)isEditing:(BOOL)selection {
    
    // is editing method for adjusting which properties are editable
    self.complexityMeter.editable = selection;
    self.ticketDescription.editable = selection;
    self.ticketTitle.enabled = selection;
    self.ticketType.enabled = selection;
    self.dateDue.enabled = selection;
    self.dateModified.enabled = NO;
    self.ticketID.enabled = NO;
    self.ticketOwner.enabled = NO;
    self.dateCreated.enabled = NO;
    
    // set alternating text color for editable fields
    UIColor *textColor = [[UIColor alloc] init];
    if(selection == YES){
        textColor = [UIColor colorWithRed:0.7
                                    green:0
                                     blue:0
                                    alpha:1];
        self.complexityMeter.selectedImage = [UIImage imageNamed:@"Red-Gear.png"];
        
    }else{
        textColor = [UIColor colorWithRed:0.27344
                                    green:0.28125
                                     blue:0.24219
                                    alpha:1];
        self.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
    }
    
    [self.ticketTitle setTextColor: textColor];
    [self.ticketType setTextColor: textColor];
    [self.ticketDescription setTextColor: textColor];
    [self.dateDue setTextColor: textColor];
    
    // hides main buttons and reveals editing buttons
    self.editButton.hidden=selection;
    self.backButton.hidden=selection;
    self.saveButton.hidden=!selection;
    self.cancelButton.hidden=!selection;
}

- (IBAction)editButton:(id)sender {
    // set to editing mode
    [self isEditing:YES];
    
}

- (IBAction)cancelButton:(id)sender {
    // remove from editing mode
    [self isEditing:NO];
    [self populateTable];
}

- (IBAction)saveButton:(id)sender {
    // remove from editing mode
    [self isEditing:NO];
}

- (void)complexityMeter:(ComplexityMeter *)complexityMeter meterDidChange:(int)complexity {
    
}
@end
