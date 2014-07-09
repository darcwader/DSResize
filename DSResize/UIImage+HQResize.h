//
//  UIImage+Resize.h
//  DSResize
//
//  Created by Darshan Sonde on 07/07/14.
//  Copyright (c) 2014 Darshan Sonde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HQResize)
-(UIImage*) hqScaleToSize:(CGSize)size usingMode:(UIViewContentMode) mode;
@end
