//
//  MKMonsterBlood.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKMonsterBlood.h"

@implementation MKMonsterBlood

-(instancetype)init{
    self = [super init];
    if(self){
        self.progressViewStyle = UIProgressViewStyleBar;
        self.tintColor = [UIColor redColor];
        self.backgroundColor = [UIColor blackColor];
        self.progress = 1.0;
    }
    
    return  self;
}

@end
