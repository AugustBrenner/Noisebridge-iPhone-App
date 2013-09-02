//
//  main.m
//  Noisebridge
//
//  Created by Ryan Brenner on 8/28/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PXEngine/PXEngine.h>

#import "NoisebridgeAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [PXEngine licenseKey:@"J66RU-JFLVC-4UHEB-GM52C-78NHE-T8PCG-0E46Q-5DUF1-0GMOG-VO240-6PUCQ-TMVQ1-A3L2O-2EQ52-2B22E-UI" forUser:@"AugustBrenner@gmail.com"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([NoisebridgeAppDelegate class]));
    }
}
