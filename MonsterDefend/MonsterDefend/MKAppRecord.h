//
//  MKAppRecord.h
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

//MKAppRecord用于保存各个类需要共享操作的app全局数据
#import <Foundation/Foundation.h>
#import "MKGrid.h"
#import "MKArchiver.h"

@interface MKAppRecord : NSObject

@property (strong ,nonatomic) UIViewController *viewController;

@property (strong ,nonatomic) NSMutableArray *gridMatrixArray;
@property (strong ,nonatomic) NSMutableArray *gridLinearArray;

@property (strong ,nonatomic) NSMutableArray *timerArray;

@property (strong ,nonatomic) NSMutableArray *monsterArray;
@property (strong ,nonatomic) NSMutableArray *roadArray;
@property (strong ,nonatomic) NSMutableArray *towerArray;
@property (strong ,nonatomic) NSString *recordExportPath;
@property  (strong , nonatomic)NSMutableArray *monsterImageArray ;
@property (assign,nonatomic) CGFloat gridWidth;
@property (assign,nonatomic) CGFloat gridHight;
@property (assign,nonatomic) int columns;
@property (assign,nonatomic) int rows;

-(void)roadRecordSave:(NSMutableArray *)_roadRecordArray andFileName:(NSString *)_fileName;
-(void)roadRecordImport:(NSMutableArray *)_roadRecordArray andFileName:(NSString *)_fileName;

@end
