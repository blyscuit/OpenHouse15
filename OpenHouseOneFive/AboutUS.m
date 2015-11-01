//
//  AboutUS.m
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 11/1/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import "AboutUS.h"

@interface AboutUS ()

@property (strong, nonatomic) IBOutlet UIImageView *topicImage;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UIView *blurView;

@end

@implementation AboutUS
@synthesize closeButton,image,title,location, content;

- (void)viewDidLoad {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *bluredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [bluredEffectView setFrame:self.blurView.bounds];
    [self.view insertSubview:bluredEffectView belowSubview:self.blurView];
    //  [self.blurView addSubview:bluredEffectView];
    
    self.topicLabel.text = [NSString stringWithFormat:@""];
    NSString *stickerName = [NSString stringWithFormat:@""];
    self.topicImage.image = [UIImage imageNamed:stickerName];
    [super viewDidLoad];
    // Do any additional setup after loading the viewt.
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
    [self.delegate aboutUsViewClose:self];
}

@end
