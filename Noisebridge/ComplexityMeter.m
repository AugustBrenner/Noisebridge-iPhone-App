//
//  ComplexityMeter.m
//  Noisebridge
//
//  Created by Ryan Brenner on 8/29/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//
//To Do: add 2D viewspace functionality to be enable multiple line complexity display for better output display UI

#import "ComplexityMeter.h"

@implementation ComplexityMeter

@synthesize unSelectedImage = _unSelectedImage;
@synthesize selectedImage = _selectedImage;
@synthesize complexity = _complexity;
@synthesize editable = _editable;
@synthesize imageViews = _imageViews;
@synthesize maxComplexity = _maxComplexity;
@synthesize midMargin = _midMargin;
@synthesize leftMargin = _leftMargin;
@synthesize minImageSize = _minImageSize;
@synthesize delegate = _delegate;
@synthesize rows = _rows;

- (void)baseInit {
    _unSelectedImage = nil;
    _selectedImage = nil;
    _complexity = 0;
    _editable = NO;
    _imageViews = [[NSMutableArray alloc] init];
    _maxComplexity = 0;
    _midMargin = 0;
    _leftMargin = 0;
    _minImageSize = CGSizeMake(0, 0);
    _delegate = nil;
    _rows = 1;
}

- (void)refresh {
    for(int i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (self.complexity >= i+1) {
            imageView.image = self.selectedImage;
        } else {
            imageView.image = self.unSelectedImage;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.unSelectedImage == nil) return;
    
    float desiredImageWidth = (self.frame.size.width - (self.leftMargin*2) - (self.midMargin*self.imageViews.count)) / self.imageViews.count;
    float imageWidth = MAX(self.minImageSize.width, desiredImageWidth);
    float imageHeight = MAX(self.minImageSize.height, self.frame.size.height);
    
    for (int i = 0; i < self.imageViews.count; ++i) {
        
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(self.leftMargin + i*(self.midMargin+imageWidth), 0, imageWidth, imageHeight);
        imageView.frame = imageFrame;
        
    }    
    
}

- (void)setMaxComplexity:(int)maxComplexity {
    _maxComplexity = maxComplexity;
    
    // Remove old image views
    for(int i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = (UIImageView *) [self.imageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
    
    // Add new image views
    for(int i = 0; i < maxComplexity; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setUnSelectedImage:(UIImage *)image {
    _unSelectedImage = image;
    [self refresh];
}

- (void)setSelectedImage:(UIImage *)image {
    _selectedImage = image;
    [self refresh];
}

- (void)setComplexity:(int)complexity {
    _complexity = complexity;
    [self refresh];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!self.editable) return;
    
    int newComplexity = 0;
    for(int i = self.imageViews.count - 1; i >= 0; i--) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (touchLocation.x > imageView.frame.origin.x) {
            newComplexity = i+1;
            break;
        }
    }
    
    self.complexity = newComplexity;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate complexityMeter:self meterDidChange:self.complexity];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
