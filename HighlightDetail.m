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
@property (strong, nonatomic) IBOutlet UIImageView *topicImage;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UIView *blurView;

@end

@implementation HighlightDetail
@synthesize image,eventTitle,location,highlight,arrDetail,closeButton;

- (void)viewDidLoad {
    
    // Blur Effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *bluredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [bluredEffectView setFrame:self.blurView.bounds];
    [self.view insertSubview:bluredEffectView belowSubview:self.blurView];
//    [self.blurView addSubview:bluredEffectView];
    
    screenHeight = self.view.frame.size.height;
    screenWidth = self.view.frame.size.width;
    [super viewDidLoad];
    
    CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
    NSString * imageName = [[NSString alloc] initWithFormat:@"%@.jpg",arrDetail[6]];
    //NSString * imageName = [[NSString alloc] initWithFormat:@"21_Art.jpg"];
    [self.image setImage:[UIImage imageNamed:imageName]];
    [self.image setContentMode:UIViewContentModeScaleAspectFill];
    [self.image setClipsToBounds:YES];
    [scrollView addSubview:self.image];
    
    float titleHeight;
    CGFloat width = screenWidth-50;
    UIFont *font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:23];
    CGRect rect = [self.arrDetail[3] boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    titleHeight = rect.size.height;
    
    self.eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, screenWidth+25, screenWidth-50, titleHeight)];
    self.eventTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:23];
    self.eventTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    self.eventTitle.numberOfLines = 0;
    self.eventTitle.textColor = [UIColor blackColor];
    self.eventTitle.text = [[NSString alloc] initWithFormat:@"%@",self.arrDetail[3]];
    [scrollView addSubview:self.eventTitle];
    
    UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(25,screenWidth+25+titleHeight, screenWidth-50, 20)];
    lblLocation.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:18];
    lblLocation.textColor = [UIColor blackColor];
    lblLocation.text = @"สถานที่";
    [scrollView addSubview:lblLocation];
    
    self.location = [[UILabel alloc] initWithFrame:CGRectMake(25+45,screenWidth+25+titleHeight,screenWidth-50-20,20)];
    self.location.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:18];
    self.location.textColor = [UIColor blackColor];
    self.location.text = [[NSString alloc] initWithFormat:@"%@",self.arrDetail[4]];
    [scrollView addSubview:self.location];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(25, screenWidth+25+titleHeight+20+10, screenWidth-50, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [scrollView addSubview:lineView];
    
    self.highlight = [[UITextView alloc] initWithFrame:CGRectMake(25, screenWidth+25+titleHeight+20+10+10, screenWidth-50, 10)];
    self.highlight.backgroundColor = [UIColor whiteColor];
    self.highlight.text = self.arrDetail[5];
    self.highlight.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:18];
    self.highlight.textColor = [UIColor blackColor];
    self.highlight.scrollEnabled = NO;
    self.highlight.editable = NO;
    self.highlight.textAlignment = NSTextAlignmentNatural;
    [self.highlight sizeToFit];
    [scrollView addSubview:self.highlight];
    
    /*
    if(self.highlight.frame.size.height+ screenWidth+25+titleHeight+20+10+10 > screenHeight){
        scrollView.contentSize = CGSizeMake(screenWidth, textView.frame.size.height+(screenWidth-30*screenWidth*ratioW+40)*6.0/9.0+(235+titleHeight)*screenHeight*ratioH);
    } else {
        scrollView.contentSize = CGSizeMake(screenWidth, screenHeight-20*screenHeight*ratioH);
    }*/
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868 longitude:151.2086 zoom:6 ];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(25, screenWidth+25+titleHeight+20+10+10+self.highlight.frame.size.height, screenWidth-50, (screenWidth-50)*2/3) camera:camera];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    //marker.snippet = @"";
    //marker.appearAnimation = kGMSMarkerAnimationPop;
    //marker.map= mapView;
//    [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(-64, 0, 0, 0)];
    
    [self.view insertSubview:scrollView belowSubview:bluredEffectView];// = scrollView;
    
    
    
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
- (IBAction)closePress:(id)sender {
    [self.delegate highlightViewClose:self];
}

@end
