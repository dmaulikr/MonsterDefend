//
//  MKAppRecord.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKAppRecord.h"

@implementation MKAppRecord

@synthesize gridArray,monsterArray,roadArray,towerArray,recordExportPath;

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
        importGrid = gridArray[importArchiver.colY][importArchiver.rowX];
        
        [_roadRecordArray addObject:importGrid];
    }
    
    
    
}

@end
