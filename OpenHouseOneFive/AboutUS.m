//
//  AboutUS.m
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 11/1/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import "AboutUS.h"

@interface AboutUS () {
    float screenWidth;
    float screenHeight;
}

@property (strong, nonatomic) IBOutlet UIImageView *topicImage;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UIView *blurView;

@end

@implementation AboutUS
@synthesize closeButton,image,aboutUsTitle,location, content,contactTableView;

- (void)viewDidLoad {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *bluredEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [bluredEffectView setFrame:self.blurView.bounds];
    [self.view insertSubview:bluredEffectView belowSubview:self.blurView];
    //  [self.blurView addSubview:bluredEffectView];
    
    self.topicLabel.text = [NSString stringWithFormat:@"About"];
   
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
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, yPostion, screenWidth, 213)];
    NSString * imageName = [[NSString alloc] initWithFormat:@"header_image_about.jpg"];
    [self.image setImage:[UIImage imageNamed:imageName]];
    [self.image setContentMode:UIViewContentModeScaleAspectFill];
    [self.image setClipsToBounds:YES];
    [scrollView addSubview:self.image];
    
    float titleHeight;
    CGFloat width = screenWidth-50;
    UIFont *font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:25];
    NSString *header = @"เปิดเรือนเยือนจุฬาฯ :\nCU Open House 2015";
    CGRect rect = [header boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    titleHeight = rect.size.height;
    
    yPostion += 15  + 213;
    self.aboutUsTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, yPostion, screenWidth-50, titleHeight+10)];
    self.aboutUsTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:25];
    self.aboutUsTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.aboutUsTitle.numberOfLines = 2;
    self.aboutUsTitle.textColor = [UIColor colorWithRed:251/255.f green:89/255.f blue:134/255.f alpha:1];
    self.aboutUsTitle.text = [[NSString alloc] initWithFormat:@"%@",header];
    [scrollView addSubview:self.aboutUsTitle];
    
    yPostion += titleHeight+10;
    
    self.content = [[UITextView alloc] initWithFrame:CGRectMake(25, yPostion, screenWidth-50, 10)];
    self.content.backgroundColor = [UIColor whiteColor];
    self.content.text = @"งาน \"เปิดเรือนเยือนจุฬาฯ (CU Open House 2015)\" จัดขึ้นภายใต้งาน \"วิศิษฏศิลปินสรรพศิลป์สโมสร\" งานนี้เป็นการเปิดโอกาสให้น้องๆ นักเรียนระดับชั้นมัธยมศึกษา ได้เข้ามารู้จักกับคณะต่างๆ ในจุฬาฯ แบบเจาะลึก ว่าคณะไหนเรียนอย่างไร มีสิ่งที่น่าสนใจอะไรบ้างในคณะ และช่วยตอบคำถามยอดฮิตอย่าง \"จบไปจะทำอะไร?\" นอกจากนี้ยังได้เรียนรู้ศิลปวัฒนธรรมของไทยที่เกี่ยวข้องกับคณะต่างๆ อีกด้วย\nเตรียมตัวมารับความสนุกสนานพร้อมทั้งสาระความรู้จากกิจกรรมบนเวทีกลางที่มีมามอบให้ตลอดทั้งงาน และพลาดไม่ได้กับกิจกรรมสุดเก๋อย่าง CU Tour ที่จะพาน้องๆ นั่งรถชมสถานที่รอบจุฬาฯ โดยมีพี่ๆ มัคคุเทศก์คอยให้ความรู้เกี่ยวกับสถานที่ต่างๆ ตลอดเส้นทาง\n\nพบกันได้ตั้งแต่วันที่ 15 - 17 พฤศจิกายน 2558\nโดยวันที่ 15 พฤศจิกายน เวลา 9.00-19.00น.\nและวันที่ 16-17 พฤศจิกายน เวลา 9.00-16.00น.\nณ จุฬาลงกรณ์มหาวิทยาลัย";
    
    self.content.font = [UIFont fontWithName:@"ThaiSansNeue-Light" size:20];
    self.content.textColor = [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1 ];
    self.content.scrollEnabled = NO;
    self.content.editable = NO;
    self.content.textAlignment = NSTextAlignmentNatural;
    [self.content sizeToFit];
    [scrollView addSubview:self.content];
    
    yPostion += self.content.frame.size.height + 10;
    self.contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, yPostion+10+20+10+5, screenWidth, 44*3 )];
    [scrollView addSubview:contactTableView];
    contactTableView.delegate = self;
    contactTableView.dataSource = self;
    
    yPostion += 44*3+10 + 20+21;
    if(yPostion > screenHeight){
        scrollView.contentSize = CGSizeMake(screenWidth,yPostion+25);
    } else {
        scrollView.contentSize = CGSizeMake(screenWidth, screenHeight+10);
    }
    
    UIView *backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 213+44, screenWidth, scrollView.contentSize.height - screenWidth)];
    backGround.backgroundColor = [UIColor whiteColor];
    [scrollView insertSubview:backGround aboveSubview:self.image];
    
    [self.view insertSubview:scrollView belowSubview:bluredEffectView];// = scrollView;

    UILabel *styConnect = [[UILabel alloc] initWithFrame:CGRectMake(18, yPostion-44*3-10-21, screenWidth, 21)];
    styConnect.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    styConnect.text = @"Stay Connected";
    [scrollView addSubview:styConnect];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset = scrollView.contentOffset.y;
    //NSLog(@"yOffset = %f",yOffset);
    if(yOffset<0) {
        self.image.frame = CGRectMake(0,yOffset+44,screenWidth-yOffset,(213)-yOffset);
        self.image.center = CGPointMake(screenWidth/2,self.image.center.y);
    } else if(yOffset>0) {
        self.image.frame = CGRectMake(0, 0.5*yOffset+44, screenWidth, 213);
        self.image.center = CGPointMake(screenWidth/2, self.image.center.y);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellReuseIdentifier = @"ReuseCell";
    
    UITableViewCell *cell = [self.contactTableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    UIImageView *contactImage;
    UILabel *contactTitle,*contactSubTitle;
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        if(indexPath.row == 0) {
            contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 7, 30, 30)];
            contactImage.image = [UIImage imageNamed:@"facebook_icon"];
            [cell.contentView addSubview:contactImage];
            
            contactTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 8, cell.frame.size.width, 15)];
            contactTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:20.4];
            contactTitle.textColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:152/255.0 alpha:1];
            contactTitle.text = @"Like us on Facebook";
            [cell.contentView addSubview:contactTitle];
            
            contactSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 23, cell.frame.size.width, 15)];
            contactSubTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:16.8];
            contactSubTitle.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
            contactSubTitle.text = @"/cuopenhouse2015";
            [cell.contentView addSubview:contactSubTitle];
            
        } else if (indexPath.row == 1) {
            contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 7, 30, 30)];
            contactImage.image = [UIImage imageNamed:@"instagram_icon"];
            [cell.contentView addSubview:contactImage];
            
            contactTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 8, cell.frame.size.width, 15)];
            contactTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:20.4];
            contactTitle.textColor = [UIColor colorWithRed:63/255.0 green:114/255.0 blue:155/255.0 alpha:1];
            contactTitle.text = @"View us on Instagram";
            [cell.contentView addSubview:contactTitle];
            
            contactSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 23, cell.frame.size.width, 15)];
            contactSubTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:16.8];
            contactSubTitle.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
            contactSubTitle.text = @"@cuopenhouse2015";
            [cell.contentView addSubview:contactSubTitle];
            
        } else if (indexPath.row == 2){
            contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 7, 30, 30)];
            contactImage.image = [UIImage imageNamed:@"twitter_icon"];
            [cell.contentView addSubview:contactImage];
            
            contactTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 8, cell.frame.size.width, 15)];
            contactTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Bold" size:20.4];
            contactTitle.textColor = [UIColor colorWithRed:85/255.0 green:172/255.0 blue:238/255.0 alpha:1];
            contactTitle.text = @"Follow us on Twitter";
            [cell.contentView addSubview:contactTitle];
            
            contactSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(63, 23, cell.frame.size.width, 15)];
            contactSubTitle.font = [UIFont fontWithName:@"ThaiSansNeue-Regular" size:16.8];
            contactSubTitle.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
            contactSubTitle.text = @"@cuopenhouse";
            [cell.contentView addSubview:contactSubTitle];
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self linkToFB];
            break;
        case 1:
            [self linkToIg];
            break;
        case 2:
            [self linkToTwt];
            break;
            
        default:
            break;
    }
    
}

-(void)linkToFB{
    
    NSURL *instagramURL = [NSURL URLWithString:@"fb://profile/885080744852208"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/cuopenhouse2015/"]];
    }
}
-(void)linkToTwt{
    
    NSURL *instagramURL = [NSURL URLWithString:@"twitter://user?screen_name=cuopenhouse"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/cuopenhouse"]];
    }
}

-(void)linkToIg{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=cuopenhouse2015"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://instagram.com/cuopenhouse2015/"]];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //prepare for segue
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
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
