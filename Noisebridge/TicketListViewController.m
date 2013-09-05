//
//  TicketListViewController.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/3/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "TicketListViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface TicketListViewController ()

@end

@implementation TicketListViewController

@synthesize ticketTable;

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
    
    ticketTable.layer.cornerRadius = 3;
    
    self.ticketArray = [[NSArray alloc] init];
    
    [self getTickets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getTickets{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Tickets...";
    
    NSURL *url = [NSURL URLWithString:@"http://noiseapp.herokuapp.com/tickets.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject)
                                         {
                                             
                                             self.ticketArray = responseObject;
                                             [self.ticketTable reloadData];
                    
                                             NSLog(@"JSON RESULT %@, %@", responseObject, [responseObject[0] objectForKey:@"title"]);
                                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject)
                                         {
                                             NSLog(@"Request Failed: %@", error);
                                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                                         }];
    
    [operation start];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.ticketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FixitTicketTableCell";
    FixitTicketTableCell *fixitTicketTableCell = (FixitTicketTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!fixitTicketTableCell) {
        fixitTicketTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    // Configure the cell...
    
    NSDictionary *dict = [self.ticketArray objectAtIndex:indexPath.row];
    
    if([dict objectForKey:@"title"] != NULL)
    {
        fixitTicketTableCell.ticketTitle.text = [dict objectForKey:@"title"];
    }
    else
    {
        fixitTicketTableCell.detailTextLabel.text = [NSString stringWithFormat:@"No Fix-It Tickets!"];
    }
    
    fixitTicketTableCell.complexityMeter.unSelectedImage = [UIImage imageNamed:@"Full-Gear.png"];
    fixitTicketTableCell.complexityMeter.selectedImage = [UIImage imageNamed:@"Empty-Gear.png"];
    fixitTicketTableCell.complexityMeter.complexity = 8;//[dict objectForKey:@"complexity"];
    fixitTicketTableCell.complexityMeter.editable = NO;
    fixitTicketTableCell.complexityMeter.maxComplexity = 8;
    
    
    if( [indexPath row] % 2)
        [fixitTicketTableCell.contentView setBackgroundColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0f]];
    else
        [fixitTicketTableCell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    
    return fixitTicketTableCell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
