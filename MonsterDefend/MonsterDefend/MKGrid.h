//
//  MKGrid.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum gridRole:NSInteger{
    
    EmptyThere = 1<<0,
    RoadThere = 1<<1,
    MonsterThere = 1<<2,
    TowerThere = 1 << 3,
    RoadThereAvailable = 1<<4,
    
}gridRole;

@interface MKGrid : UIButton

@property (assign,nonatomic) int rowX;
@property (assign,nonatomic) int colY;
@property (assign,nonatomic) int moveX;
@property (assign,nonatomic) int moveY;
@property (assign,nonatomic) int moveIndex;


//初始化后，一定要记得给width和height赋值
@property (assign,nonatomic) CGFloat width;
@property (assign,nonatomic) CGFloat height;
@property (assign,nonatomic) gridRole gridRole;


- (instancetype)initWithBackGroundColor:(UIColor *)_gridBackGroundColor;

-(void)reset;

@end
