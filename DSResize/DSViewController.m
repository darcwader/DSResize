//
//  DSViewController.m
//  DSResize
//
//  Created by Darshan Sonde on 07/07/14.
//  Copyright (c) 2014 Darshan Sonde. All rights reserved.
//

#import "DSViewController.h"
#import "UIImage+HQResize.h"
#import "UIImage+Resizing.h"

@interface DSViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (nonatomic) UIImagePickerController *picker;
@end

@implementation DSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (IBAction)cameraButtonTapped:(id)sender {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    self.picker = picker;
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSDate *start = [NSDate date];
    self.topImageView.image = [image scaleToSize:CGSizeMake(self.topImageView.bounds.size.width,round(self.topImageView.bounds.size.height)) usingMode:NYXResizeModeAspectFill];
    NSLog(@"normal time = %f",[[NSDate date] timeIntervalSinceDate:start]);
    self.topScrollView.contentSize = self.topImageView.image.size;
    start = [NSDate date];
    self.bottomImageView.image = [image hqScaleToSize:CGSizeMake(self.topImageView.bounds.size.width,round(self.topImageView.bounds.size.height)) usingMode:UIViewContentModeScaleAspectFill];
    NSLog(@"hq time = %f",[[NSDate date] timeIntervalSinceDate:start]);
    self.bottomScrollView.contentSize = self.bottomImageView.image.size;
    
    
    NSData *d = UIImageJPEGRepresentation(self.topImageView.image,1.0);
    NSUUID *uuid = [NSUUID UUID];
    NSString *file = [NSString stringWithFormat:@"%@_normal.jpg",[uuid UUIDString]];
    NSURL *fileUrl = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:file];
    [d writeToURL:fileUrl atomically:NO];
    
    d =UIImageJPEGRepresentation(self.bottomImageView.image,1.0);
    file = [NSString stringWithFormat:@"%@_hq.jpg",[uuid UUIDString]];
    fileUrl = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:file];
    [d writeToURL:fileUrl atomically:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    [self dismissViewControllerAnimated:YES completion:NULL];
}








-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if(scrollView == self.topScrollView)
        return self.topImageView;
    else
        return self.bottomImageView;
}

@end
