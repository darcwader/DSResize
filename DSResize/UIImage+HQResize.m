//
//  UIImage+Resize.m
//  DSResize
//
//  Created by Darshan Sonde on 07/07/14.
//  Copyright (c) 2014 Darshan Sonde. All rights reserved.
//

#import "UIImage+HQResize.h"
#import <Accelerate/Accelerate.h>
const int kNumberOfComponentsPerARBGPixel = 4;


@implementation UIImage (HQResize)

- (UIImage *)cropToSize:(CGSize)newSize usingMode:(UIViewContentMode) cropMode {
	const CGSize size = self.size;
	CGFloat x, y;
	switch (cropMode)
	{
		case UIViewContentModeTopLeft:
			x = y = 0.0f;
			break;
        case UIViewContentModeTop:
			x = (size.width - newSize.width) * 0.5f;
			y = 0.0f;
			break;
		case UIViewContentModeTopRight:
			x = size.width - newSize.width;
			y = 0.0f;
			break;
		case UIViewContentModeBottomLeft:
			x = 0.0f;
			y = size.height - newSize.height;
			break;
        case UIViewContentModeBottom:
			x = (size.width - newSize.width) * 0.5f;
			y = size.height - newSize.height;
			break;

		case UIViewContentModeBottomRight:
			x = size.width - newSize.width;
			y = size.height - newSize.height;
			break;
            
		case UIViewContentModeCenter:
			x = (size.width - newSize.width) * 0.5f;
			y = (size.height - newSize.height) * 0.5f;
			break;
            
		case UIViewContentModeLeft:
			x = 0.0f;
			y = (size.height - newSize.height) * 0.5f;
			break;
		case UIViewContentModeRight:
			x = size.width - newSize.width;
			y = (size.height - newSize.height) * 0.5f;
			break;
		default: // Default to top left
			x = y = 0.0f;
        break;
    }
    
	if (self.imageOrientation == UIImageOrientationLeft || self.imageOrientation == UIImageOrientationLeftMirrored || self.imageOrientation == UIImageOrientationRight || self.imageOrientation == UIImageOrientationRightMirrored)
	{
		CGFloat temp = x;
		x = y;
		y = temp;
	}
    
	CGRect cropRect = CGRectMake(x * self.scale, y * self.scale, newSize.width * self.scale, newSize.height * self.scale);
    
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
	UIImage* cropped = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];
    
	CGImageRelease(croppedImageRef);
    
	return cropped;
}
-(UIImage*) hqScaleToSize:(CGSize)newSize usingMode:(UIViewContentMode) mode
{
    const size_t originalWidth = (size_t)(self.size.width * self.scale);
	const size_t originalHeight = (size_t)(self.size.height * self.scale);
    
    CGFloat widthRatio = newSize.width / self.size.width;
    CGFloat heightRatio = newSize.height / self.size.height;
    CGFloat widthScale = 1.0f;
    CGFloat heightScale = 1.0f;
    
    switch(mode) {
        case UIViewContentModeScaleAspectFill:
            widthScale = heightScale = MAX(widthRatio,heightRatio);
            
            break;
        case UIViewContentModeScaleAspectFit:
            widthScale = heightScale = MIN(widthRatio,heightRatio);
            break;
        case UIViewContentModeScaleToFill:
            widthScale = widthRatio;
            heightScale = heightRatio;
            break;
        case UIViewContentModeTopLeft:
        case UIViewContentModeTop:
		case UIViewContentModeTopRight:
		case UIViewContentModeBottomLeft:
        case UIViewContentModeBottom:
		case UIViewContentModeBottomRight:
		case UIViewContentModeCenter:
		case UIViewContentModeLeft:
		case UIViewContentModeRight:
            return [self cropToSize:newSize usingMode:mode];
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported mode %ld, only UIViewContentModeScaleAspectFill, UIViewContentModeScaleAspectFit,UIViewContentModeScaleToFill are supported",(long)mode];
    }
    
    const size_t destWidth = widthScale * self.size.width;
    const size_t destHeight = heightScale * self.size.height;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGContextRef bmContext = CGBitmapContextCreate(NULL, originalWidth, originalHeight, 8/*bits per component*/, originalWidth * kNumberOfComponentsPerARBGPixel, colorSpaceRef, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
	if (!bmContext)
		return nil;
    CGContextSetShouldAntialias(bmContext, true);
	CGContextSetAllowsAntialiasing(bmContext, true);
	CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = originalWidth, .size.height = originalHeight}, self.CGImage);
    
	UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}
    
	vImage_Buffer src = {data, originalHeight, originalWidth, originalWidth * kNumberOfComponentsPerARBGPixel};
    
    CGContextRef destContext = CGBitmapContextCreate(NULL, destWidth, destHeight, 8/*bits per comp*/, destWidth*kNumberOfComponentsPerARBGPixel, colorSpaceRef, kCGBitmapByteOrderDefault| kCGImageAlphaPremultipliedFirst);
    UInt8* outt = (UInt8*) CGBitmapContextGetData(destContext);
	vImage_Buffer dest = {outt, destHeight, destWidth, destWidth*kNumberOfComponentsPerARBGPixel};
    
    vImage_Error err = vImageScale_ARGB8888(&src, &dest, NULL,kvImageEdgeExtend|kvImageHighQualityResampling);
    NSAssert(err == kvImageNoError,@"Error scaling with vimage");
    /*if (err != kvImageNoError) {
        NSString *errorReason = [NSString stringWithFormat:@"vImageScale returned error code %zd", err];
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   self, @"sourceImage",
                                   [NSValue valueWithCGSize:destSize], @"destSize",
                                   nil];
        
        NSException *exception = [NSException exceptionWithName:@"HighQualityImageScalingFailureException" reason:errorReason userInfo:errorInfo];
        @throw exception;
    }*/
    
    CGContextRelease(bmContext);
    
	CGImageRef resizedImageRef = CGBitmapContextCreateImage(destContext);
	UIImage* resized = [UIImage imageWithCGImage:resizedImageRef scale:self.scale orientation:self.imageOrientation];
    
	CGImageRelease(resizedImageRef);
    CGContextRelease(destContext);
    
    /* cropping saves some space, may need to be done.
     size_t top = 0;
    size_t left = 0;
    switch(mode) {
        case UIViewContentModeScaleAspectFill:
            if(destWidth > destHeight) {
                left = (destWidth-newSize.width)/2;
            } else {
                top = (destHeight-newSize.height)/2;
            }
            resized = [resized cropToSize:newSize usingMode:UIViewContentModeCenter];//investigate to do this in vImage
            break;
        default:
            break;
    }*/
    
	return resized;
}

@end
