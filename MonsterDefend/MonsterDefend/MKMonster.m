//
//  MKMonster.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//

#import "MKMonster.h"

@implementation MKMonster
{
    int index ;   //在路上的下标为多少
}

@synthesize appRecord,blood,money,rowX,colY,is_attacked;

-(instancetype)initWithAppRecord:(MKAppRecord *)_appRecord
{
    self = [super init];
    
    if (self) {
        NSLog(@"Monster is create ");
        
        
        blood = 100;
        money = 100;
        
        //初始化怪在路上的下标为0
        index = 0 ;
        
        //初始化共享appRecord
        appRecord = _appRecord;
        NSLog(@"monster init appRecord.monsterimangearray.count:%lu",appRecord.monsterImageArray.count);
        
        //刷图片
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(Show_Picture) userInfo:nil repeats:YES];
        
        
        [NSTimer  scheduledTimerWithTimeInterval:1 target:self selector:@selector(Walk_Road) userInfo:nil repeats:YES];
        
    }
    
    return self ;
}


-(void)Show_Picture
{
    if(blood>0){
        static int i = 0 ;
        
        
        NSMutableArray *walkImageArray;
        
        if(index < appRecord.roadArray.count-1 && appRecord.roadArray.count>2){
            
            MKGrid *currentGrid,*nextGrid;
            currentGrid = appRecord.roadArray[index];
            nextGrid = appRecord.roadArray[index+1];
            
            //向上走
            if(nextGrid.rowX<currentGrid.rowX){
                walkImageArray = appRecord.monsterImageArray[0];
            }
            //向下走
            if(nextGrid.rowX>currentGrid.rowX){
                walkImageArray = appRecord.monsterImageArray[1];
            }
            //向左走
            if(nextGrid.colY<currentGrid.colY){
                walkImageArray = appRecord.monsterImageArray[2];
            }
            //向右走
            if(nextGrid.colY>currentGrid.colY){
                walkImageArray = appRecord.monsterImageArray[3];
            }
            
            
        }
        else if(index == appRecord.roadArray.count-1 ){
            
            MKGrid *currentGrid,*preGrid;
            currentGrid = appRecord.roadArray[index];
            preGrid = appRecord.roadArray[index-1];
            
            //向上走
            if(preGrid.rowX>currentGrid.rowX){
                walkImageArray = appRecord.monsterImageArray[0];
            }
            //向下走
            if(preGrid.rowX<currentGrid.rowX){
                walkImageArray = appRecord.monsterImageArray[1];
            }
            //向左走
            if(preGrid.colY>currentGrid.colY){
                walkImageArray = appRecord.monsterImageArray[2];
            }
            //向右走
            if(preGrid.colY<currentGrid.colY){
                walkImageArray = appRecord.monsterImageArray[3];
            }
            
            
        }
        else{
            walkImageArray = appRecord.monsterImageArray[1];
        }
        
        //walkImageArray = appRecord.monsterImageArray[1];
        UIImage *Image ;
        Image = walkImageArray[i];
        
        
        
        MKGrid *currentGrid ;
        currentGrid = appRecord.roadArray[index];
        
        [currentGrid setImage:Image forState:UIControlStateNormal];
        //    if(self.is_attacked){
        //        Road.Button.backgroundColor = [UIColor redColor];
        //
        //    }
        //加入进度条
        MKMonsterBlood *ProgressBar;
        ProgressBar = [[MKMonsterBlood alloc]init];
        ProgressBar.frame = CGRectMake(3, 0, currentGrid.width-5, 20);
        ProgressBar.progress = blood/100;
        [currentGrid.imageView addSubview:ProgressBar];
        // currentGrid.backgroundColor = [UIColor whiteColor];
        
        i = (i + 1) % (walkImageArray.count-1) ;
        
    }
}

-(void)Walk_Road
{
    if (index < appRecord.roadArray.count-1) {
        MKGrid *roadGrid ;
        roadGrid = appRecord.roadArray[index];
        [roadGrid setImage:nil forState:UIControlStateNormal];
        roadGrid.backgroundColor = [UIColor brownColor];
        NSLog(@"删除进度条");
        for (MKMonsterBlood *tmpProcessView in roadGrid.imageView.subviews) {
            [tmpProcessView removeFromSuperview];
            NSLog(@"删除进度条0k");
            
        }
        rowX = roadGrid.rowX;
        colY = roadGrid.colY;
        is_attacked = 0;
        NSLog(@"self.col:%d,self.row:%d",colY,rowX);
        index++ ;
    }
}

@end
