//
//  MKMonster.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MKGrid.h"
#import "MKAppRecord.h"
#import "MKMonsterBlood.h"

@interface MKMonster : NSObject

//导入的共享全局变量
@property  (strong , nonatomic)MKAppRecord *appRecord ;

//自己的变量
@property  (strong , nonatomic)UIImageView *monsterView ;
@property  (assign , nonatomic) CGFloat blood ;
@property  (assign , nonatomic) int money ;

@property  (assign , nonatomic)int  rowX ;
@property  (assign , nonatomic)int  colY ;

@property  (assign , nonatomic)CGFloat  originX ;
@property  (assign , nonatomic)CGFloat  originY ;


@property  (assign , nonatomic)BOOL  is_attacked;

@property  (strong , nonatomic) NSTimer *monsterWalkTimer;
@property  (strong , nonatomic) NSTimer *monsterShowPictureTimer;



-(instancetype)initWithAppRecord:(MKAppRecord *)_allRecord;
-(void)destroyMonster;

@end
