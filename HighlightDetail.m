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
    //  [self.blurView addSubview:bluredEffectView];
    if ([self.arrDetail[2] intValue] == 40) {
        self.topicLabel.text = [NSString stringWithFormat:@"%@",arrDetail[1]];
    }
    else
        self.topicLabel.text = [NSString stringWithFormat:@"คณะ%@",arrDetail[1]];
    
    NSString *stickerName = [NSString stringWithFormat:@"sticker_%@.png",self.arrDetail[2]];
    self.topicImage.image = [UIImage imageNamed:stickerName];
    
    screenHeight = self.view.frame.size.height;
    screenWidth = self.view.frame.size.width;
    
    [super viewDidLoad];
    
    float yPostion = 0.0;
    yPostion += 44;
    
    CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, yPostion, screenWidth, screenWidth)];
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
    
    yPostion += 15  +screenWidth;
    self.eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, yPostion, screenWidth-50, titleHeight+10)];
    self.eventTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:23];
    self.eventTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.eventTitle.numberOfLines = 0;
    self.eventTitle.textColor = [UIColor blackColor];
    self.eventTitle.text = [[NSString alloc] initWithFormat:@"%@",self.arrDetail[3]];
    [scrollView addSubview:self.eventTitle];
    
    yPostion += titleHeight+10;
    UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(25,yPostion+1, screenWidth-50, 20)];
    lblLocation.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:20];
    lblLocation.textColor = [UIColor blackColor];
    lblLocation.text = @"สถานที่";
    [scrollView addSubview:lblLocation];
    
    float locationHeight;
    CGFloat locationWidth = screenWidth-25-50-25;
    UIFont *locationFont = [UIFont fontWithName:@"ThaiSansNeue-Light" size:20];
    CGRect rectOfLocationText = [self.arrDetail[4] boundingRectWithSize:CGSizeMake(locationWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:locationFont} context:nil];
    locationHeight = rectOfLocationText.size.height;
    
    self.location = [[UILabel alloc] initWithFrame:CGRectMake(25+50,yPostion-7,screenWidth-50-50,locationHeight+10)];
    self.location.font = [UIFont fontWithName:@"ThaiSansNeue-Light" size:20];
    self.location.textColor = [UIColor blackColor];
    self.location.text = [[NSString alloc] initWithFormat:@"%@",self.arrDetail[4]];
    self.location.lineBreakMode = NSLineBreakByWordWrapping;
    self.location.numberOfLines = 0;
    [scrollView addSubview:self.location];
    
    yPostion += locationHeight+10;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(25, yPostion, screenWidth-50, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:163/255 green:163/255 blue:163/255 alpha:1];
    [scrollView addSubview:lineView];
    
    yPostion += 10;
    self.highlight = [[UITextView alloc] initWithFrame:CGRectMake(25, yPostion, screenWidth-50, 10)];
    self.highlight.backgroundColor = [UIColor whiteColor];
    self.highlight.text = self.arrDetail[5];
    self.highlight.font = [UIFont fontWithName:@"ThaiSansNeue-Light" size:20];
    self.highlight.textColor = [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1 ];
    self.highlight.textColor = [UIColor blackColor];
    self.highlight.scrollEnabled = NO;
    self.highlight.editable = NO;
    self.highlight.textAlignment = NSTextAlignmentNatural;
    self.highlight.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.highlight sizeToFit];
    [scrollView addSubview:self.highlight];
    
    yPostion += 10+self.highlight.frame.size.height;
    NSString *latString = [NSString stringWithFormat:@"%@",arrDetail[7]];
    NSString *lgnString = [NSString stringWithFormat:@"%@",arrDetail[8]];
    double lat = [latString doubleValue];
    double lgn = [lgnString doubleValue];
    NSLog(@"%f %f",lat,lgn);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lgn zoom:14];
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.73548 longitude:100.53147 zoom:12 ];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(25, yPostion, screenWidth-50, (screenWidth-50)*2/3) camera:camera];
    mapView.myLocationEnabled = NO;
    mapView.indoorEnabled = NO;
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat , lgn);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.position = camera.target;
    if([arrDetail[2] intValue] == 40) {
         marker.snippet = [NSString stringWithFormat:@"%@",arrDetail[1]];
    }
    else
        marker.snippet = [NSString stringWithFormat:@"คณะ%@",arrDetail[1]];
    
    marker.title = [NSString stringWithFormat:@"%@",arrDetail[0]];
    marker.map = mapView;
    marker.icon = [UIImage imageNamed:[NSString stringWithFormat:@"pin_%@",arrDetail[2]]];
    //marker.icon =[UIImage imageNamed:@"sticker_21.png"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    //[scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(-64, 0, 0, 0)];
    
    yPostion += (screenWidth-50)*2/3;
    if(self.highlight.frame.size.height+ yPostion > screenHeight){
        scrollView.contentSize = CGSizeMake(screenWidth,yPostion+25);
    } else {
        scrollView.contentSize = CGSizeMake(screenWidth, screenHeight);
    }
    
    //add background
    UIView *backGround = [[UIView alloc] initWithFrame:CGRectMake(0, screenWidth+44, screenWidth, scrollView.contentSize.height - screenWidth)];
    backGround.backgroundColor = [UIColor whiteColor];
    [scrollView insertSubview:backGround aboveSubview:self.image];
    
    [scrollView addSubview:mapView];
    [self.view insertSubview:scrollView belowSubview:bluredEffectView];// = scrollView;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset = scrollView.contentOffset.y;
    //NSLog(@"yOffset = %f",yOffset);
    if(yOffset<0) {
        self.image.frame = CGRectMake(0,yOffset+44,screenWidth-yOffset,(screenWidth)-yOffset);
        self.image.center = CGPointMake(screenWidth/2,self.image.center.y);
    } else if(yOffset>0) {
        self.image.frame = CGRectMake(0, 0.5*yOffset+44, screenWidth, screenWidth);
        self.image.center = CGPointMake(screenWidth/2, self.image.center.y);
    }
    
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
