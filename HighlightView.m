//
//  HighlightView.m
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 10/30/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import "HighlightView.h"
#import "OpenHouseOneFive-Swift.h"

@interface HighlightView ()


@property (strong,nonatomic) HighLightJsonParser *jsonParser;

@property (strong,nonatomic) NSArray *arrDetail;


@end

@implementation HighlightView
@synthesize arrDetail,jsonParser,highlightList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.highlightList.delegate = self;
    self.highlightList = [[UITableView alloc] init];
    self.jsonParser = [[HighLightJsonParser alloc] init];
    self.arrDetail = [[NSArray alloc] initWithArray:[self.jsonParser serializeJSON]];
    
    
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3
#define ABVR_TAG 4
    
    static NSString *CellIdentifier = @"ReuseCell";
    UIImageView *artWork,*facTag;
    UILabel *name,*engName;
    UITableViewCell *cell = [self.highlightList dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        artWork = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 58, 58)];
        [cell.contentView addSubview:artWork];
        
    }
    else {
        artWork = (UIImageView *)[cell.contentView viewWithTag:PHOTO_TAG];
    }
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@.jpg",self.arrDetail[4]];
    [artWork setImage:[UIImage imageNamed:imageName]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d",[self.arrDetail count]);
    return [self.arrDetail count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
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
