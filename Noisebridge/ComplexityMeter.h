//
//  ComplexityMeter.h
//  Noisebridge
//
//  Created by Ryan Brenner on 8/29/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComplexityMeter;

@protocol ComplexityMeterDelegate
- (void)complexityMeter:(ComplexityMeter *)complexityMeter meterDidChange:(int)complexity;
@end

@interface ComplexityMeter : UIView

@property (strong, nonatomic) UIImage *unSelectedImage;
@property (strong, nonatomic) UIImage *selectedImage;
@property (assign, nonatomic) int complexity;
@property (assign) BOOL editable;
@property (strong) NSMutableArray * imageViews;
@property (assign, nonatomic) int maxComplexity;
@property (assign) int midMargin;
@property (assign) int leftMargin;
@property (assign) CGSize minImageSize;
@property (assign) id <ComplexityMeterDelegate> delegate;

@end
