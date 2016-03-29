//
//  HXImageEdtingViewController.m
//  miXin
//
//  Created by HAIXUN on 14-5-29.
//  Copyright (c) 2014年 HAIXUN. All rights reserved.
//

#import "HXImageEdtingViewController.h"
#define kLeftMarginWidth 13
#define kTopMarginHeight 137//137
#define kRoundWidth (WIDTH_OF_SCREEN - kLeftMarginWidth * 2)
@interface HXImageEdtingViewController ()<UIScrollViewDelegate>
{
    CGSize imageSize;
}
@end

@implementation HXImageEdtingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    self.imageScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)];
    self.imageScroll.delegate=self;
    [self.view insertSubview:self.imageScroll atIndex:0];
    self.bgMaskView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN)];
    [self.view insertSubview:self.bgMaskView atIndex:1];
    
    self.imageScroll.showsHorizontalScrollIndicator=NO;
    self.imageScroll.showsVerticalScrollIndicator=NO;

    if (HEIGHT_OF_SCREEN < 500) {
        self.bgMaskView.image=[UIImage imageNamed:@"mask_iphone4"];
    }
    else{
        self.bgMaskView.image=[UIImage imageNamed:@"mask_iphone5"];
    }
    
    [self initZoom];
}

-(void)initZoom{
    
    [self.imageView removeFromSuperview];
    [self.imageView removeFromSuperview];
    
    imageSize = self.getImage.size;
    
    // 初始位置及大小
    CGRect imageViewFrame = CGRectMake(kLeftMarginWidth,
                                       kTopMarginHeight,
                                       imageSize.width,
                                       imageSize.height);
    
    
    // 判断 长或宽 不足相框长度的处理
    CGFloat miniZoom = kRoundWidth / imageSize.width;
    if (imageSize.width < imageSize.height) {
        if (imageSize.width < kRoundWidth) {
            CGFloat b = kRoundWidth / imageSize.width;
            imageViewFrame.size.width = kRoundWidth;
            imageViewFrame.size.height = imageSize.height * b;
        }
    }else{
        if (imageSize.height < kRoundWidth) {
            CGFloat b = kRoundWidth / imageSize.height;
            imageViewFrame.size.width = imageSize.width * b;
            imageViewFrame.size.height = kRoundWidth;
            miniZoom = kRoundWidth / imageViewFrame.size.height;
        }
    }
    
    imageSize = imageViewFrame.size;
    
    self.imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setImage:self.getImage];
    [self.imageScroll addSubview:self.imageView];
    
    
    // Inti ScrollView
    
    [self.imageScroll setMinimumZoomScale:miniZoom];
    [self.imageScroll setMaximumZoomScale:2.f];
    [self.imageScroll setBackgroundColor:[UIColor blackColor]];
    
    [self.imageScroll setZoomScale:self.imageScroll.minimumZoomScale];
    
    // Resize ContentSize
    [self resizeContentSizeOfScrollView];
}


- (void)resizeContentSizeOfScrollView{
    // Reset Content Size Of Scrollview
    CGSize contentSize = CGSizeMake(
                                    imageSize.width * self.imageScroll.zoomScale +
                                    (kLeftMarginWidth * 2),
                                    imageSize.height * self.imageScroll.zoomScale +
                                    (kTopMarginHeight * 2));
    [self.imageScroll setContentSize:contentSize];
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
   // [scrollView setZoomScale:scale animated:YES];
    [self resizeContentSizeOfScrollView];
    
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)edtingAction:(id)sender {
    if ([sender tag]==10) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([sender tag]==11){
        
        CGFloat zoomScale =  self.imageScroll.zoomScale;
        
        CGFloat x = self.imageScroll.contentOffset.x / zoomScale;
        CGFloat y = self.imageScroll.contentOffset.y / zoomScale;
        
        
        // 计算宽度(Image中所显示在屏幕上的宽度)
        CGFloat width;
        
        //如果是等比例
        if (zoomScale == self.imageScroll.minimumZoomScale) {
            width = self.getImage.size.width;
        }else{
            width = kRoundWidth / zoomScale;
            
        }
        
        CGFloat height =  width;
        
        CGRect rect = CGRectMake(x, y, width, height);
        
        CGImageRef cr = CGImageCreateWithImageInRect([self.getImage CGImage], rect);
        
        UIImage *cropped = [UIImage imageWithCGImage:cr];
        
        CGImageRelease(cr);

        [self.clipDelegate getClipImage:cropped inVC:self];
       
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}

@end
