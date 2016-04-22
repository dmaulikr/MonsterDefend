//
//  MKGrid.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKGrid.h"

@implementation MKGrid
{
    UIColor *gridBackGroundColor;
}

@synthesize moveX,moveY,moveIndex, gridRole;

- (instancetype)initWithBackGroundColor:(UIColor *)_gridBackGroundColor
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@"Picture/grass.png"] forState:UIControlStateNormal];
        self.backgroundColor = _gridBackGroundColor;
        gridBackGroundColor = _gridBackGroundColor;
        
    }
    return self;
}

-(void)reset{
   
    [self setImage:[UIImage imageNamed:@"Picture/grass.png"] forState:UIControlStateNormal];
    self.backgroundColor = gridBackGroundColor;
    moveX = 0;
    moveY = 0;
    moveIndex = 0;
    self.gridRole = EmptyThere ;
    
    for (UIView *tmpView in self.imageView.subviews) {
        [tmpView removeFromSuperview];
    }
}

@end
