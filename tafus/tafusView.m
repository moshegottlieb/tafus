//
//  tafusView.m
//  tafus
//
//  Created by Moshe Gottlieb on 06/08/2016.
//  Copyright © 2016 Sharkfood. All rights reserved.
//

#import "tafusView.h"
@import AVFoundation;

@interface tafusView()

@property (nonnull,nonatomic,readonly) NSBundle* bundle;
@property (nonnull,nonatomic,strong) NSArray<NSImage*>* images;
@property (nonatomic,assign) NSInteger i;
@property (nonatomic,assign) NSRect imageFrame;

@end


@implementation tafusView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    NSMutableArray* array = [NSMutableArray new];
    int i=1;
    NSURL* url;
    while ((url = [self.bundle URLForResource:[NSString stringWithFormat:@"tafus %02d",i] withExtension:@"png"])){
        NSImage* image = [[NSImage alloc] initWithContentsOfURL:url];
        [array addObject:image];
        ++i;
    }
    self.images = array;
    [self setAnimationTimeInterval:0.02];
    self.imageFrame = NSZeroRect;
    return self;
}


-(NSBundle*)bundle{
    return [NSBundle bundleForClass:[self class]];
}

- (void)startAnimation
{
    [super startAnimation];
    NSImage* image = [self.images firstObject];
    CGFloat desiredScaleFactor = [self.window backingScaleFactor];
    CGFloat actualScaleFactor = [image recommendedLayerContentsScale:desiredScaleFactor];
    NSSize size = image.size;
    size.width = size.width / (desiredScaleFactor/actualScaleFactor);
    size.height = size.height / (desiredScaleFactor/actualScaleFactor);
    NSRect frame = self.bounds;
    NSRect f = self.bounds;
    if (self.isPreview){
        f = AVMakeRectWithAspectRatioInsideRect(size, frame);
    } else {
        f.size.width = frame.size.width / 4;
        f.size.height = f.size.height / (frame.size.width / size.width);
    }
    f.origin.x = (frame.size.width - f.size.width)/2;
    f.origin.y = (frame.size.height - f.size.height)/2;
    
    _imageFrame = f;
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)animateOneFrame
{
    NSImage* image = self.images[(self.i % self.images.count)];
    [image drawInRect:self.imageFrame];
    ++self.i;
    [super animateOneFrame];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    NSNib* nib = [[NSNib alloc] initWithNibNamed:@"About" bundle:self.bundle];
    NSArray* ret = nil;
    [nib instantiateWithOwner:nil topLevelObjects:&ret];
    //NSString* cls = NSStringFromClass([[ret firstObject] class]);

    return [ret firstObject];
}

@end
