//
//  MKTower.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MKAppRecord.h"

@interface MKTower : NSObject

@property  (strong , nonatomic)MKAppRecord *appRecord ;

@property  (strong , nonatomic)UIImageView *showImage ;
@property  (assign , nonatomic) int range ; //攻击范围
@property  (assign , nonatomic) int power ; //攻击力


-(instancetype)initWithImages:(MKAppRecord *)_appRecord;

-(void)startAnimation;
-(void)stopAnimation ;

@end
