# GifAnimation
加载gif动画图片

1.ARC下加载动画图片</br>
2.在Demo中通过调用</br>
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"loadingHd.gif" ofType:nil];
    NSData * imageData = [NSData dataWithContentsOfFile:filePath];
    MCGIFImageView *gifImageView = [[MCGIFImageView alloc] initWithFrame:CGRectMake(100, 100, 75, 110)];
    [gifImageView setData:imageData];
即可。</br>
