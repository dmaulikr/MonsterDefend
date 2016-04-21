//
//  ViewController.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKGrid.h"
#import "MKAppRecord.h"
#import "MKMonster.h"
#import "MKTower.h"
@interface ViewController : UIViewController

@property (assign,nonatomic) CGFloat topSpace;
@property (assign,nonatomic) CGFloat bottomSpace;
@property (assign,nonatomic) CGFloat leftSpace;
@property (assign,nonatomic) CGFloat rightSpace;
@property (assign,nonatomic) CGFloat gridSpace;
@property (assign,nonatomic) CGFloat gridWidth;
@property (assign,nonatomic) CGFloat gridHeight;
@property (assign,nonatomic) CGFloat columns;
@property (assign,nonatomic) CGFloat rows;
@property (assign,nonatomic) CGFloat screenWidth;
@property (assign,nonatomic) CGFloat screenHeight;
@property (assign,nonatomic) UIColor *mainBackGroundColor;
@property (assign,nonatomic) UIColor *gridBackGroundColor;

@end

