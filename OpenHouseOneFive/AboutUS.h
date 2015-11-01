//
//  AboutUS.h
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 11/1/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AboutUSViewDelegate;

@interface AboutUS : UIViewController<UIScrollViewDelegate>

@property (weak,nonatomic) id<AboutUSViewDelegate> delegate;

@property (nonatomic,strong) UIButton *closeButton;

@property (strong, nonatomic) UIImageView *image;

@property (strong, nonatomic) UILabel *aboutUsTitle;

@property (strong, nonatomic) UILabel *location;

@property (strong, nonatomic) UITextView *content;

@end

@protocol AboutUSViewDelegate <NSObject>
-(void)aboutUsViewClose:(AboutUS*)controller;

@end