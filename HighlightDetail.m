//
//  HighlightDetail.m
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 10/30/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import "HighlightDetail.h"

@interface HighlightDetail () {
    float screenWidth;
    float screenHeight;
}

@end

@implementation HighlightDetail
@synthesize image,eventTitle,location,highlight,arrDetail,closeButton;

- (void)viewDidLoad {
    screenHeight = self.view.frame.size.height;
    screenWidth = self.view.frame.size.width;
    [super viewDidLoad];
    
    CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
    NSString * imageName = [[NSString alloc] initWithFormat:@"%@.jpg",arrDetail[6]];
    [self.image setImage:[UIImage imageNamed:imageName]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
