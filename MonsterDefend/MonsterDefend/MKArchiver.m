//
//  MKArchiver.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKArchiver.h"

@implementation MKArchiver

@synthesize rowX,colY;

//自己调用
//解码
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init] ;
    if (self) {
        
        //解码中用到的KEY必须跟编码时的KEY值一致
        rowX = [aDecoder decodeIntForKey:@"rowX"];
        colY = [aDecoder decodeIntForKey:@"colY"];
        
    }
    return self ;
}

//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //将类成员进行编码
    [aCoder  encodeInt:rowX forKey:@"rowX"];
    [aCoder  encodeInt:colY forKey:@"colY"];
    
    
}

@end
