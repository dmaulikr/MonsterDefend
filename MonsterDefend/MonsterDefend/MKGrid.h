//
//  MKGrid.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum gridRole:NSUInteger{
    
    EmptyThere = 1<<0,
    RoadThere = 1<<1,
    MonsterThere = 1<<2,
    TowerThere = 1 << 3,
    
}gridRole;

@interface MKGrid : UIButton

@property (assign,nonatomic) int rowX;
@property (assign,nonatomic) int colY;
@property (assign,nonatomic) int width;
@property (assign,nonatomic) int height;
@property (assign,nonatomic) gridRole gridRole;

@end
