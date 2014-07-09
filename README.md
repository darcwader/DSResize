DSResize
========

HighQuality Image Scaling / Resizing using vImage.


Usage
------

```objectivec
@interface UIImage (HQResize)
-(UIImage*) hqScaleToSize:(CGSize)size usingMode:(UIViewContentMode) mode;
@end
```

Comparison with Reference Images
--------------------------------

Images are resized to identical sizes.

| Core Graphics | vImage |
|---------------|--------|
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/49B809AF-E4DB-4081-A660-7EB9CD44E5F3_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/49B809AF-E4DB-4081-A660-7EB9CD44E5F3_hq.jpg) |
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/89B0395A-CDB8-482D-96F6-481F5A6EDEA3_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/89B0395A-CDB8-482D-96F6-481F5A6EDEA3_hq.jpg) |
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/A4C20094-1380-4D9A-AAE4-DC22FBDA960F_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/A4C20094-1380-4D9A-AAE4-DC22FBDA960F_hq.jpg) |
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/C64FDE85-B104-413D-88FB-75717A5A2FCD_nromal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/C64FDE85-B104-413D-88FB-75717A5A2FCD_hq.jpg) |
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/6434C234-6810-4C5A-AB12-FE87DC770E83_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/6434C234-6810-4C5A-AB12-FE87DC770E83_hq.jpg) |




References
-----------

[http://www.galloway.me.uk/2012/01/uiimageorientation-exif-orientation-sample-images/][1]
[http://stackoverflow.com/questions/10068095/uiimage-become-fuzzy-when-it-was-scaled-whyios-5-0][2]
[https://github.com/Nyx0uf/NYXImagesKit][3]
