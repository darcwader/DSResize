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
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/C64FDE85-B104-413D-88FB-75717A5A2FCD_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/C64FDE85-B104-413D-88FB-75717A5A2FCD_hq.jpg) |
| ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/6434C234-6810-4C5A-AB12-FE87DC770E83_normal.jpg) | ![](https://raw.githubusercontent.com/darcwader/DSResize/master/Images/Comparison/6434C234-6810-4C5A-AB12-FE87DC770E83_hq.jpg) |



Computation Time
------------------

| Core Graphics | vImage       | Image Resolution | slower by |
|---------------|--------------|------------------|-----------|
| 0.014590      | 0.024121     | 2130x2900        | 1.65 times|
| 0.167856      | 0.317625     | 3072x2304        | 1.89 times|
| 0.003484      | 0.001751     | 64x64            | 0.50 times|
| 0.074183      | 0.146807     | 1000x1247        | 1.97 times|
| 0.342612      | 1.761384     | 3744x5616        | 5.14 times|

The slowness of hq image is apparent, but the absolute time it takes for even image is quite small.


References
-----------

[http://www.galloway.me.uk/2012/01/uiimageorientation-exif-orientation-sample-images/][1]
[http://stackoverflow.com/questions/10068095/uiimage-become-fuzzy-when-it-was-scaled-whyios-5-0][2]
[https://github.com/Nyx0uf/NYXImagesKit][3]
