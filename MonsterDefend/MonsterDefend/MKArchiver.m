//
//  MKArchiver.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKArchiver.h"

@implementation MKArchiver

@synthesize rowX,colY,moveX,moveY,moveIndex,gridRole;

//自己调用
//解码
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init] ;
    if (self) {
        
        //解码中用到的KEY必须跟编码时的KEY值一致
        rowX = [aDecoder decodeIntForKey:@"rowX"];
        colY = [aDecoder decodeIntForKey:@"colY"];
        moveX = [aDecoder decodeIntForKey:@"moveX"];
        moveY = [aDecoder decodeIntForKey:@"moveY"];
        moveIndex = [aDecoder decodeIntForKey:@"moveIndex"];
        
        //注释width和height防止不同设备的grid尺寸冲突
//        width = [aDecoder decodeDoubleForKey:@"width"];
//        height = [aDecoder decodeDoubleForKey:@"height"];
        gridRole = [aDecoder decodeIntegerForKey:@"gridRole"];
        
    }
    return self ;
}

//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //将类成员进行编码
    [aCoder  encodeInt:rowX forKey:@"rowX"];
    [aCoder  encodeInt:colY forKey:@"colY"];
    [aCoder  encodeInt:moveX forKey:@"moveX"];
    [aCoder  encodeInt:moveY forKey:@"moveY"];
    [aCoder encodeInt:moveIndex forKey:@"moveIndex"];
//    [aCoder encodeDouble:width forKey:@"width"];
//    [aCoder encodeDouble:height forKey:@"height"];
    [aCoder encodeInteger:gridRole forKey:@"gridRole"];
    
    
    
}

@end
