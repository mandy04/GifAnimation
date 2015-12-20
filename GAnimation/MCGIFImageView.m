//
//  MCGIFImageView.m
//  封装Demo
//
//  Created by llbt on 15/11/30.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import "MCGIFImageView.h"
#import <ImageIO/ImageIO.h>

@implementation MCGIFImageFrame

@synthesize image = _image;
@synthesize duration = _duration; 

@end

@interface MCGIFImageView()

- (void)resetTimer;

- (void)showNextImage;

@end

@implementation MCGIFImageView
@synthesize imageFrameArray = _imageFrameArray;
@synthesize timer = _timer;
@synthesize animating = _animating;


- (void)resetTimer {
    if (_timer && _timer.isValid) {
        [_timer invalidate];
    }
}

- (void)setData:(NSData *)imageData {
    if (!imageData) {
        return;
    }
    
    [self resetTimer];
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (size_t i = 0 ; i < count; i++) {
        MCGIFImageFrame *gifImage = [[MCGIFImageFrame alloc]init];
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        gifImage.image = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        NSDictionary *frameProperties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, i, NULL));
        gifImage.duration = [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString *)kCGImagePropertyGIFDelayTime]doubleValue];
        //修改动画间隔
        gifImage.duration = MAX(gifImage.duration, 0.01);
        [tmpArray addObject:gifImage];
        CGImageRelease(image);
    }
    
    CFRelease(source);
    
    self.imageFrameArray = nil;
    if (tmpArray.count > 1) {
        self.imageFrameArray = tmpArray;
        _currentImageIndex = -1;
        _animating = YES;
        [self showNextImage];
    }else {
        
        self.image = [UIImage imageWithData:imageData];
    }
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    [self resetTimer];
    self.imageFrameArray = nil;
    _animating = NO;
}

- (void)showNextImage {
    if (!_animating) {
        return;
    }
    _currentImageIndex = (++_currentImageIndex) % _imageFrameArray.count;
    MCGIFImageFrame *gifImage = [_imageFrameArray objectAtIndex:_currentImageIndex];
    [super setImage:[gifImage image]];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:gifImage.duration target:self selector:@selector(showNextImage) userInfo:nil repeats:NO];
}
- (void)setAnimating:(BOOL)animating {
    if (_imageFrameArray.count < 2) {
        _animating = animating;
        return;
    }
    
    if (!_animating && animating) {
        //continue
        if (!_timer) {
            [self showNextImage];
        }
    }else if (_animating && !animating){
        //stop
        _animating = animating;
        [self resetTimer];
    }
}
@end
