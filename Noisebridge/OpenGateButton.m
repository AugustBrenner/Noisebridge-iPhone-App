//
//  OpenGateButton.m
//  Noisebridge
//
//  Created by Ryan Brenner on 8/28/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "OpenGateButton.h"

@implementation OpenGateButton



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* noisebridgeRed = [UIColor colorWithRed: 0.748 green: 0.356 blue: 0.356 alpha: 0.878];
    UIColor* backgroundGunMetal = [UIColor colorWithRed: 0.195 green: 0.195 blue: 0.195 alpha: 1];
    UIColor* boarderRed = [UIColor colorWithRed: 0.181 green: 0 blue: 0 alpha: 1];
    UIColor* shadowRed = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Gradient Declarations
    NSArray* buttonGradientColors = [NSArray arrayWithObjects:
                                     (id)noisebridgeRed.CGColor,
                                     (id)[UIColor colorWithRed: 0.465 green: 0.178 blue: 0.178 alpha: 0.939].CGColor,
                                     (id)boarderRed.CGColor, nil];
    CGFloat buttonGradientLocations[] = {0, 0.4, 1};
    CGGradientRef buttonGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)buttonGradientColors, buttonGradientLocations);
    
    //// Shadow Declarations
    UIColor* outerButtonShadow = shadowRed;
    CGSize outerButtonShadowOffset = CGSizeMake(2.1, 4.1);
    CGFloat outerButtonShadowBlurRadius = 3;
    
    //// Frames
    CGRect frame = rect;
    
    
    //// Abstracted Attributes
    NSString* roundedRectangleContent = @"";
    
    
    //// MainButton
    {
        //// Rounded Rectangle Drawing
        CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(frame) + 3, CGRectGetMinY(frame) + 2, 273, 96);
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 20];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerButtonShadowOffset, outerButtonShadowBlurRadius, outerButtonShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [roundedRectanglePath addClip];
        CGContextDrawLinearGradient(context, buttonGradient,
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        [boarderRed setStroke];
        roundedRectanglePath.lineWidth = 2;
        [roundedRectanglePath stroke];
        [backgroundGunMetal setFill];
        [roundedRectangleContent drawInRect: roundedRectangleRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 13] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    }
    
    
    //// Cleanup
    CGGradientRelease(buttonGradient);
    CGColorSpaceRelease(colorSpace);
    
}


@end
