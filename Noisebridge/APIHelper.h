//
//  APIHelper.h
//  Noisebridge
//
//  Created by Ryan Brenner on 9/7/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHelper : NSObject

FOUNDATION_EXPORT NSString *const gateOpenURL;



FOUNDATION_EXPORT NSString *const ticketGenerationURL;

FOUNDATION_EXPORT NSString *const ticketTitleParameter;
FOUNDATION_EXPORT NSString *const ticketDescriptionParameter;
FOUNDATION_EXPORT NSString *const ticketComplexityParameter;



FOUNDATION_EXPORT NSString *const ticketRequestURL;

FOUNDATION_EXPORT NSString *const ticketTitleResponse;
FOUNDATION_EXPORT NSString *const ticketDescriptionResponse;
FOUNDATION_EXPORT NSString *const ticketDueDateResponse;
FOUNDATION_EXPORT NSString *const ticketCreationDateResponse;
FOUNDATION_EXPORT NSString *const ticketModificationDateResponse;
FOUNDATION_EXPORT NSString *const ticketComplexityResponse;
FOUNDATION_EXPORT NSString *const ticketIDResponse;
FOUNDATION_EXPORT NSString *const ticketOwnerResponse;
FOUNDATION_EXPORT NSString *const ticketRequestorResponse;
FOUNDATION_EXPORT NSString *const ticketStatusResponse;
FOUNDATION_EXPORT NSString *const ticketTypeResponse;


@end
