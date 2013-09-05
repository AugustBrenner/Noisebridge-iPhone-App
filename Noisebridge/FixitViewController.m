//
//  FixitViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 8/29/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "FixitViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface FixitViewController ()

@end

@implementation FixitViewController

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
    self.complexityMeter.unSelectedImage = [UIImage imageNamed:@"Full-Gear.png"];
    self.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
    self.complexityMeter.complexity = 0;
    self.complexityMeter.editable = YES;
    self.complexityMeter.maxComplexity = 8;
    self.complexityMeter.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClearButton:(id)sender {
    self.ticketTitle.text = @"";
    self.ticketDescription.text = @"";
    self.complexityMeter.complexity = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)SubmitFixit:(id)sender {
    
    // Begin progress HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Sending Ticket...";
    
    // Grab title from the text field
    NSString *title = self.ticketTitle.text;
    
    // Grab description from text field
    NSString *description = self.ticketDescription.text;
    
    // Grab Complexity value from the Complexity value meter
    NSString *complexity = [NSString stringWithFormat:@"%d", self.complexityMeter.complexity];
    /*
     // Get device unique ID
     UIDevice *device = [UIDevice currentDevice];
     NSUUID *identifierForVendor = [device identifierForVendor];
     NSString *vendorIdString = [identifierForVendor UUIDString];
     */
    
    
    // Prepare HTTP Request
    NSURL *url = [NSURL URLWithString:@"http://noiseapp.herokuapp.com/tickets.json"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            //vendorIdString, @"vendor_id",
                            title, @"ticket[title]",
                            description, @"ticket[description]",
                            complexity, @"ticket[complexity]",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // Successful request
        
        // Formulate a response String and Display it in NSLog
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        
        
        // End progress HUD
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // Failed Request
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // Log the errors
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        // End progress HUD
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}

- (void)complexityMeter:(ComplexityMeter *)complexityMeter meterDidChange:(int)complexity {
    
}

@end
