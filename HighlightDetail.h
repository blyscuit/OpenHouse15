//
//  HighlightDetail.h
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 10/30/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface HighlightDetail : UIViewController

@property (strong, nonatomic) UIImageView *image;

@property (strong, nonatomic) UILabel *eventTitle;

@property (strong, nonatomic) UILabel *location;

@property (strong, nonatomic) UITextView *highlight;

@property (nonatomic,strong) NSArray *arrDetail;

@property (nonatomic,strong) UIButton *closeButton;

@end
