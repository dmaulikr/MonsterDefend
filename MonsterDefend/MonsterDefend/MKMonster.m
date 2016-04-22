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
    //在路上的下标为多少
    int index ;
    //指定自己显示的图片
    NSMutableArray *walkImageArray;
}

@synthesize appRecord,blood,money,rowX,colY,originX,originY, is_attacked,monsterWalkTimer,monsterShowPictureTimer,monsterView;

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
        
        
        if(appRecord.roadArray.count>0){
            MKGrid *roadGrid ;
            roadGrid = appRecord.roadArray[0];
            monsterView = [[UIImageView alloc]init];
            monsterView.frame = roadGrid.frame;
            walkImageArray = appRecord.monsterImageArray[roadGrid.moveIndex];
            monsterView.animationImages = walkImageArray;
            monsterView.animationDuration=0.45 ;
            monsterView.animationRepeatCount = 0 ;//forever
            [monsterView startAnimating];
            NSLog(@"animating...%d",roadGrid.moveIndex);
           
            //加入进度条
            MKMonsterBlood *ProgressBar;
            ProgressBar = [[MKMonsterBlood alloc]init];
            ProgressBar.frame = CGRectMake(3, 0, roadGrid.width-5, 20);
            ProgressBar.progress = blood/100;
            [monsterView addSubview:ProgressBar];
            
            [appRecord.viewController.view addSubview:monsterView];
            
           
            
            //刷图片
//            monsterShowPictureTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(Show_Picture) userInfo:nil repeats:YES];
//            [[NSRunLoop currentRunLoop] addTimer:monsterShowPictureTimer forMode:NSRunLoopCommonModes];
//            [appRecord.timerArray addObject:monsterShowPictureTimer];
            
//            
            monsterWalkTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(Walk_Road) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:monsterWalkTimer forMode:NSRunLoopCommonModes];
            [appRecord.timerArray addObject:monsterWalkTimer];
        }
    }
    
    return self ;
}

-(void)destroyMonster{
    [monsterShowPictureTimer invalidate];
    [monsterWalkTimer invalidate];
    [monsterView removeFromSuperview];
}


-(void)Walk_Road
{
    if (index <= (appRecord.roadArray.count-1)*10) {
        int inGridMoveNum;
        inGridMoveNum = index%10;
        
        MKGrid *roadGrid ;
        roadGrid = appRecord.roadArray[index/10];
        rowX = roadGrid.rowX;
        colY = roadGrid.colY;
        
        //进入新的grid后重置monsterView相关参数
        if(inGridMoveNum==0){
            walkImageArray = appRecord.monsterImageArray[roadGrid.moveIndex];
            monsterView.animationImages = walkImageArray;
            monsterView.animationDuration=0.45 ;
            monsterView.animationRepeatCount = 0 ;//forever
            [monsterView startAnimating];
            originX = roadGrid.frame.origin.x;
            originY = roadGrid.frame.origin.y;
            NSLog(@"directoin change...");
        }
        
        self.monsterView.frame = CGRectMake(originX+inGridMoveNum*roadGrid.width/10*roadGrid.moveX, originY+inGridMoveNum*roadGrid.height/10*roadGrid.moveY, roadGrid.frame.size.width,roadGrid.frame.size.height);
        
        is_attacked = 0;
        NSLog(@"self.col:%d,self.row:%d,roadGrid.moveIndex:%d",colY,rowX,roadGrid.moveIndex);
        index++ ;
        
        
    }
}

#if 0
-(void)Show_Picture
{
    if(blood>0){
        static int i = 0 ;
        NSMutableArray *walkImageArray;
        MKGrid *currentGrid;
        currentGrid = appRecord.roadArray[index];
        walkImageArray = appRecord.monsterImageArray[currentGrid.moveIndex];
        UIImage *Image ;
        Image = walkImageArray[i];
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

#endif

@end
