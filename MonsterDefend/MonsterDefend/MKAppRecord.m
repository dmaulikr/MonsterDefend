//
//  MKAppRecord.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKAppRecord.h"

@implementation MKAppRecord

@synthesize gridMatrixArray,monsterArray,roadArray,towerArray,recordExportPath;

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.recordExportPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSLog(@"%@:recordExportPath:%@",[self class],recordExportPath);
    }
    return self;
}

-(void)roadRecordSave:(NSMutableArray *)_roadRecordArray andFileName:(NSString *)_fileName{
    
    NSString *writePath = [recordExportPath stringByAppendingPathComponent:_fileName];
    NSLog(@"writePath:%@",writePath);
    
    //测试写入ok
    //[writePath writeToFile:writePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *saveArray = [[NSMutableArray alloc]init];
    
    for(MKGrid *saveGrid in _roadRecordArray){
        MKArchiver *saveArchiver = [[MKArchiver alloc]init];
        saveArchiver.rowX = saveGrid.rowX;
        saveArchiver.colY = saveGrid.colY;
        saveArchiver.moveX = saveGrid.moveX;
        saveArchiver.moveY = saveGrid.moveY;
        saveArchiver.moveIndex = saveGrid.moveIndex;
        saveArchiver.width = saveGrid.width;
        saveArchiver.height = saveGrid.height;
        saveArchiver.gridRole = saveGrid.gridRole;
        [saveArray addObject:saveArchiver];
    }
    
    if([NSKeyedArchiver  archiveRootObject:saveArray toFile:writePath]){
        NSLog(@"%@:%@saved to %@ successfully!",[self class],_fileName,writePath);
    }
    else{
        NSLog(@"%@:%@saved to %@ failed!",[self class],_fileName,writePath);
    }
}

-(void)roadRecordImport:(NSMutableArray *)_roadRecordArray andFileName:(NSString *)_fileName{
    
    [_roadRecordArray removeAllObjects];
    
    NSMutableArray *importArray = [NSKeyedUnarchiver  unarchiveObjectWithFile:_fileName];
    NSLog(@"import_fileName:%@",_fileName);
    NSLog(@"importArray.count:%lu",importArray.count);
    for(MKArchiver *importArchiver in importArray){
        
        MKGrid *importGrid;
        importGrid = gridMatrixArray[importArchiver.colY][importArchiver.rowX];
        
        importGrid.rowX = importArchiver.rowX;
        importGrid.colY = importArchiver.colY;
        importGrid.moveX = importArchiver.moveX;
        importGrid.moveY = importArchiver.moveY;
        importGrid.moveIndex = importArchiver.moveIndex;
        importGrid.width = importArchiver.width;
        importGrid.height = importArchiver.height;
        importGrid.gridRole = importArchiver.gridRole;
        
        [_roadRecordArray addObject:importGrid];
    }
    
    
    
}

@end
