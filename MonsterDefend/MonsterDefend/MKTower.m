//
//  MKTower.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKTower.h"

@implementation MKTower
{
    NSMutableArray *Images ;
}
@synthesize appRecord,showImage, power,range;
-(instancetype)initWithImages:(MKAppRecord *)_appRecord{
    
    self = [super init];
    
    if (self) {
        NSLog(@"Tower is create ...");
        
        range = 100 ;
        power = 10 ;
        
        
    }
    
    return self;
}

-(void)startAnimation{
    showImage.animationImages = Images;
    showImage.animationDuration=0.45 ;
    showImage.animationRepeatCount = 0 ;//forever
    [showImage startAnimating];
}
-(void)stopAnimation{
    
    [showImage stopAnimating];
    
}
@end
