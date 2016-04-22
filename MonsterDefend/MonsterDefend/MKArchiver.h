//
//  MKArchiver.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MKArchiver : NSObject<NSCoding>
@property (assign,nonatomic) int rowX;
@property (assign,nonatomic) int colY;
@property (assign,nonatomic) int moveX;
@property (assign,nonatomic) int moveY;
@property (assign,nonatomic) int moveIndex;


//初始化后，一定要记得给width和height赋值
@property (assign,nonatomic) double width;
@property (assign,nonatomic) double height;
@property (assign,nonatomic) NSUInteger gridRole;
@end
