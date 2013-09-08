//
//  APIHelper.m
//  Noisebridge
//
//  Created by Ryan Brenner on 9/7/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper
// API Constants that should be altered and added to upon changing the API

// door open API url
NSString *const gateOpenURL = @"http://pony.noise/gate/";



// request
// ticket generation API url and parameters for dictionary to post
NSString *const ticketGenerationURL = @"http://noiseapp.herokuapp.com/tickets.json";

NSString *const ticketTitleParameter = @"ticket[title]";
NSString *const ticketDescriptionParameter = @"ticket[description]";
NSString *const ticketComplexityParameter = @"ticket[complexity]";



// response
// ticket request API url and response paramers
NSString *const ticketRequestURL = @"http://noiseapp.herokuapp.com/tickets.json";

// most of these are used in the ticketSummaryViewController
NSString *const ticketTitleResponse = @"title"; //used in the ticketListViewController
NSString *const ticketDescriptionResponse = @"description";
NSString *const ticketDueDateResponse = @"due_at"; //used in the ticketListViewController
NSString *const ticketCreationDateResponse = @"created_at"; //used in the ticketListViewController
NSString *const ticketModificationDateResponse = @"updated_at";
NSString *const ticketComplexityResponse = @"complexity";
NSString *const ticketIDResponse = @"id";
NSString *const ticketOwnerResponse = @"owner_id";
NSString *const ticketRequestorResponse = @"requestor_id";
NSString *const ticketStatusResponse = @"status";
NSString *const ticketTypeResponse = @"ticket_type";

@end

