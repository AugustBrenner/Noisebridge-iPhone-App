//
//  NoisebridgeViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 8/28/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "NoisebridgeViewController.h"
#import "MBProgressHUD.h"
#import "AFHTTPClient.h"
#import "SBJson.h"

@interface NoisebridgeViewController ()

@end

@implementation NoisebridgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}
  - (IBAction)doorUnlock:(id)sender {
      
      // Begin progress HUD
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.labelText = @"Sending Code...";
      
      
      // Prepare HTTP Request
      NSURL *url = [NSURL URLWithString:@"http://pony.noise/gate/"];
      AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
      
      [httpClient getPath:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          // Successful request
          
          // Formulate a response String and Display it in NSLog
          NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
          NSLog(@"Request Successful, response '%@'", responseStr);
          
          
          // End progress HUD
          [MBProgressHUD hideHUDForView:self.view animated:YES];
          
          // Failed Request
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          // 403 error handler
          if ([error.localizedDescription compare: @" Expected status code in (200-299), got 403"] == TRUE) {
          }
          
          // Log the errors
          NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
          
          // End progress HUD
          [MBProgressHUD hideHUDForView:self.view animated:YES];
          
      }];

    }


@end
