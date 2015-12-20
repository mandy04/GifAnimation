//
//  MCGIFImageView.h
//  封装Demo
//
//  Created by llbt on 15/11/30.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCGIFImageFrame : NSObject

@property (nonatomic) double duration;
@property (nonatomic,strong) UIImage *image;

@end


@interface MCGIFImageView : UIImageView
{
    NSInteger _currentImageIndex;
}

@property (nonatomic,strong) NSArray *imageFrameArray;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic) BOOL animating;

- (void)setData:(NSData *)imageData;
@end
