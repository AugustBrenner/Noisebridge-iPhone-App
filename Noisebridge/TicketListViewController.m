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
#import "TicketSummaryViewController.h"
#import "APIHelper.h"

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
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
     
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
    
    NSURL *url = [NSURL URLWithString:ticketRequestURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject)
                                         {
                                             
                                             //self.ticketArray = responseObject;
                                             NSArray *valueSortedArray;
                                             NSArray *nullValueSortedArray;
                                             NSMutableArray *valueArray = [NSMutableArray new];
                                             NSMutableArray *nullValueArray = [NSMutableArray new];
                                             for (NSDictionary *dict in responseObject) {
                                                 if (![[dict objectForKey:ticketDueDateResponse] isKindOfClass:[NSNull class]]){
                                                     [valueArray addObject:dict];
                                                 }
                                                 else
                                                 {
                                                     [nullValueArray addObject:dict];                                                 }

                                             }
                                             

                                             // sort dated responses object using a descriptor by due date
                                             NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:ticketDueDateResponse ascending:YES];
                                             NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
                                             valueSortedArray = [valueArray sortedArrayUsingDescriptors:sortDescriptors];
                                             
                                             // sort undated responses object using a descriptor by created date
                                             dateDescriptor = [[NSSortDescriptor alloc] initWithKey:ticketCreationDateResponse ascending:YES];
                                             sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
                                             nullValueSortedArray = [nullValueArray sortedArrayUsingDescriptors:sortDescriptors];
                                             
                                             NSArray *adjustedArray = [nullValueSortedArray arrayByAddingObject:[nullValueArray objectAtIndex:0]];
                                             
                                             // concatinate the two arrays
                                             self.ticketArray = [valueSortedArray arrayByAddingObjectsFromArray:adjustedArray];
                                             
                                    
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
    if([indexPath row] == 0){
        static NSString *CellIdentifier = @"TableViewHeader";
        UITableViewCell *tableViewHeader = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [tableViewHeader.contentView setBackgroundColor:[UIColor whiteColor]];
        return tableViewHeader;
    }
    else{
        static NSString *CellIdentifier = @"FixitTicketTableCell";
        FixitTicketTableCell *fixitTicketTableCell = (FixitTicketTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!fixitTicketTableCell) {
            fixitTicketTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        }
        // Configure the cell...
        
        NSDictionary *dict = [self.ticketArray objectAtIndex:(indexPath.row-1)];
        
        // set tableview cell titles from dictionary
        if([dict objectForKey:ticketTitleResponse] != NULL)
        {
            fixitTicketTableCell.ticketTitle.text = [dict objectForKey:ticketTitleResponse];
        }
        else
        {
            fixitTicketTableCell.ticketTitle.text = [NSString stringWithFormat:@"No Fix-It Tickets!"];
        }
        
        
        // set tableview dates from dictionary
        if (![[dict objectForKey:ticketDueDateResponse] isKindOfClass:[NSNull class]]){
            NSDate *date = [self.dateFormat dateFromString:[dict objectForKey:ticketDueDateResponse]];
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:date];
            fixitTicketTableCell.dueDate.text = [NSString stringWithFormat:@"%d/%d", [components day], [components month]];
        }
        else
        {
            fixitTicketTableCell.dueDate.text = [NSString stringWithFormat:@""];
        }

        
        // set alternating background color for table cells
        if( [indexPath row] % 2)
            [fixitTicketTableCell.contentView setBackgroundColor:[UIColor lightGrayColor]];
        else
            [fixitTicketTableCell.contentView setBackgroundColor:[UIColor whiteColor]];
        
        
        return fixitTicketTableCell;
    }
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toTicketSummary"]) {
        NSIndexPath *indexPath = [self.ticketTable indexPathForSelectedRow];
        TicketSummaryViewController *ticketSummaryViewController = (TicketSummaryViewController *)segue.destinationViewController;
        ticketSummaryViewController.ticketSummary = [self.ticketArray objectAtIndex:indexPath.row];
    }
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
