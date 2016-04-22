//
//  ViewController.m
//  MonsterDefend
//
//  Created by LeeMichael on 4/21/16.
//  Copyright © 2016 MichaelLee. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    //app的一些全局变量
    NSMutableArray *gridMatrixArray;
    NSMutableArray *gridLinearArray;
    
        //要记得将所有的timer对象加到这个Array中
    NSMutableArray *timerArray;
 
    NSMutableArray *monsterArray;
    NSMutableArray *roadArray;
    NSMutableArray *towerArray;
    NSMutableArray *monsterImageArray;
    BOOL is_NewRoad;
    BOOL is_GameStart;
    
    
    
    //用于保存各类共享的全局变量的对象
    MKAppRecord *appRecord;
    
    //customized varialbes:
    UIColor *highlightColor;
}

@synthesize topSpace,bottomSpace,leftSpace,rightSpace,gridSpace,gridWidth,gridHeight,columns,rows,screenWidth,screenHeight,mainBackGroundColor,gridBackGroundColor;









- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //app环境初始化
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight =[[UIScreen mainScreen] bounds].size.height;
    columns = 6;
    rows = 8;
    topSpace = 100;
    bottomSpace = 70;
    leftSpace = 10;
    rightSpace = 10;
    gridSpace = 0;
    mainBackGroundColor = [UIColor lightGrayColor];
    gridBackGroundColor = [UIColor grayColor];
    highlightColor = [self getColorFromNum:100];
    gridWidth = (screenWidth - leftSpace-rightSpace-gridSpace*(columns-1))/columns;
    gridHeight = (screenHeight - topSpace - bottomSpace-gridSpace*(rows-1))/rows;
    
    //全局对象初始化
    gridMatrixArray = [[NSMutableArray alloc]init];
    gridLinearArray = [[NSMutableArray alloc]init];
    timerArray = [[NSMutableArray alloc]init];
    monsterArray = [[NSMutableArray alloc]init];
    roadArray = [[NSMutableArray alloc]init];
    towerArray = [[NSMutableArray alloc]init];
    monsterImageArray = [[NSMutableArray alloc]init];
    
    appRecord = [[MKAppRecord alloc]init];
    appRecord.viewController = self;
    appRecord.gridMatrixArray = gridMatrixArray;
    appRecord.gridLinearArray = gridLinearArray;
    appRecord.timerArray = timerArray;
    appRecord.monsterArray = monsterArray;
    appRecord.roadArray = roadArray;
    appRecord.towerArray = towerArray;
    [self initMonsterPicture];
    appRecord.monsterImageArray = monsterImageArray;
    
    
    
    //初始化主视图
    self.view.backgroundColor = mainBackGroundColor;
    for(int j = 0 ; j<rows; j++ ){
        NSMutableArray *viewRow;
        viewRow = [[NSMutableArray alloc]init];
        for (int i = 0;i<columns;i++) {
            MKGrid *newGrid = [[MKGrid alloc]init];
            newGrid.frame = CGRectMake(leftSpace+gridWidth*i+gridSpace*i, topSpace+gridHeight*j+gridSpace*j, gridWidth, gridHeight);
            newGrid.backgroundColor = gridBackGroundColor;
            [newGrid setImage:[UIImage imageNamed:@"Picture/grass.png"] forState:UIControlStateNormal];
            newGrid.rowX = i;
            newGrid.colY = j;
            newGrid.width=gridWidth;
            newGrid.height=gridHeight;
            // [newGrid setTitle:[NSString stringWithFormat:@"x%dy%d",newGrid.rowX,newGrid.colY] forState:UIControlStateNormal];
            
            //设置grid触发事件，可选,###注意，其中action调用的方法gridTouchAtion的默认参数就是newGrid!
            [newGrid addTarget:self action:@selector(gridTouchAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //将grid加入控制数组和view中
            [viewRow addObject:newGrid];
            [gridLinearArray addObject:newGrid];
            [self.view addSubview:newGrid];
        }
        [gridMatrixArray addObject:viewRow];
    }
    
#if 1
    
    
    //视图中grid的控制数组测试
    //    MKGrid *tmpGrid = gridMatrixArray[3][0];
    //    tmpGrid.backgroundColor = [UIColor greenColor];
    
    //个性化视图，可以添加subView...
    //新建路按键
    UIButton *newRoadButton;
    newRoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newRoadButton.frame = CGRectMake(leftSpace, screenHeight-bottomSpace*9/10,(screenWidth-leftSpace-rightSpace)/4-10,bottomSpace*4/5);
    [newRoadButton setTitle:@"新建路" forState:UIControlStateNormal];
    [newRoadButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newRoadButton.backgroundColor = [UIColor grayColor];
    
    //触发事件
    [newRoadButton addTarget:self action:@selector(newRoadFlag:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newRoadButton];
    
    //保存路按键
    UIButton *saveRoadButton;
    saveRoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveRoadButton.frame = CGRectMake(leftSpace+(screenWidth-leftSpace-rightSpace)/4, screenHeight-bottomSpace*9/10,(screenWidth-leftSpace-rightSpace)/4-10,bottomSpace*4/5);
    [saveRoadButton setTitle:@"保存路" forState:UIControlStateNormal];
    [saveRoadButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveRoadButton.backgroundColor = [UIColor grayColor];
    
    //触发事件
    [saveRoadButton addTarget:self action:@selector(saveRoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveRoadButton];
    
    //导入路按键
    UIButton *importRoadButton;
    importRoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    importRoadButton.frame = CGRectMake(leftSpace+(screenWidth-leftSpace-rightSpace)*2/4, screenHeight-bottomSpace*9/10,(screenWidth-leftSpace-rightSpace)/4-10,bottomSpace*4/5);
    [importRoadButton setTitle:@"导入路" forState:UIControlStateNormal];
    [importRoadButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    importRoadButton.backgroundColor = [UIColor grayColor];
    
    //触发事件
    [importRoadButton addTarget:self action:@selector(importRoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:importRoadButton];
    
    //开始按键
    UIButton *startGameButton;
    startGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startGameButton.frame = CGRectMake(leftSpace+(screenWidth-leftSpace-rightSpace)*3/4, screenHeight-bottomSpace*9/10,(screenWidth-leftSpace-rightSpace)/4-10,bottomSpace*4/5);
    [startGameButton setTitle:@"开始游戏" forState:UIControlStateNormal];
    [startGameButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startGameButton.backgroundColor = [UIColor grayColor];
    
    //触发事件
    [startGameButton addTarget:self action:@selector(startGameEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startGameButton];
    
#endif
}

//开始游戏
-(void)startGameEvent:(UIButton *)sender{
    if(is_NewRoad==NO && roadArray.count>0){
        
        if(is_GameStart==NO){
            is_GameStart = YES;
            [self generateNewMonster];
            NSTimer *monsterGenerate = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(generateNewMonster) userInfo:nil repeats:YES];
            [timerArray addObject:monsterGenerate];
            [[NSRunLoop currentRunLoop] addTimer:monsterGenerate forMode:NSRunLoopCommonModes];
            
            [sender setTitle:@"重新开始" forState:UIControlStateNormal];
        }
        else{
            
            [self restartgridMatrixArray];
            [sender setTitle:@"开始游戏" forState:UIControlStateNormal];
            is_GameStart = NO;
        }
    }
}

-(void)generateNewMonster{
    
    if(monsterArray.count<roadArray.count*5/5){
    MKMonster *newMonster = [[MKMonster alloc]initWithAppRecord:appRecord];
    [monsterArray addObject:newMonster];
    }
}

//初始化所用到的图片
-(void)initMonsterPicture{
    NSMutableArray *ImagesDown  ;
    NSMutableArray *ImagesLeft  ;
    NSMutableArray *ImagesRight ;
    NSMutableArray *ImagesUp    ;
    
    
    
    ImagesDown = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"Picture/1.png"] , [UIImage imageNamed:@"Picture/2.png"],[UIImage imageNamed:@"Picture/3.png"],[UIImage imageNamed:@"Picture/4.png"],nil];
    
    ImagesLeft = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"Picture/5.png"] , [UIImage imageNamed:@"Picture/6.png"],[UIImage imageNamed:@"Picture/7.png"],[UIImage imageNamed:@"Picture/8.png"],nil];
    
    
    ImagesRight = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"Picture/9.png"] , [UIImage imageNamed:@"Picture/10.png"],[UIImage imageNamed:@"Picture/11.png"],[UIImage imageNamed:@"Picture/12.png"],nil];
    
    ImagesUp  = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"Picture/13.png"] , [UIImage imageNamed:@"Picture/14.png"],[UIImage imageNamed:@"Picture/15.png"],[UIImage imageNamed:@"Picture/16.png"],nil];
    
    
    monsterImageArray = [NSMutableArray arrayWithObjects:ImagesUp,ImagesDown,ImagesLeft,ImagesRight,nil];
    NSLog(@"init picture count:%lu",monsterImageArray.count);
    
}

//导入指定的路
-(void)importRoad{
    NSString *readPath = [[NSBundle mainBundle] pathForResource:@"roadArray" ofType:@"plist"];
    //stringByAppendingPathComponent:@"Documents/roadArray.plist"];
    [self restartgridMatrixArray];
    [appRecord roadRecordImport:roadArray andFileName:readPath];
    
    
    
    NSLog(@"roadArray.count:%lu",roadArray.count);
    for(MKGrid *tmpGrid in roadArray){
        tmpGrid.backgroundColor = [UIColor brownColor];
        [tmpGrid setImage:nil forState:UIControlStateNormal];
        tmpGrid.gridRole = RoadThere;
    }
}

//重置主视图和游戏设置
-(void)restartgridMatrixArray{
    
    for (NSTimer *timer in timerArray ) {
        [timer invalidate];
    }
    for (MKMonster *tmpMonster in monsterArray){
        [tmpMonster destroyMonster];
    }
    [monsterArray removeAllObjects];
    [roadArray removeAllObjects];
    [towerArray removeAllObjects];
    
    for(NSMutableArray *tmpArray in gridMatrixArray){
        for(MKGrid *tmpGrid in tmpArray){
            
            [tmpGrid reset];
           
        }
    }
}
//保存生成的路
-(void)saveRoad{
    
    [appRecord roadRecordSave:roadArray andFileName:@"roadArray.plist"];
}

//新建路功能的开启和关闭
-(void)newRoadFlag:(UIButton *)sender{
    if(is_NewRoad == NO && is_GameStart==NO){
        is_NewRoad = YES;
        [self restartgridMatrixArray];
        sender.backgroundColor = highlightColor;
        for (MKGrid *tmpGrid in gridLinearArray) {
            tmpGrid.backgroundColor = highlightColor;
        }
    }
    else if(is_GameStart==NO){
        is_NewRoad = NO;
        sender.backgroundColor = gridBackGroundColor;
        [self deHightlight];
    }
}

//grid触发事件的调用方法
-(void)gridTouchAction:(MKGrid *)sender{
    
    //sender.backgroundColor = highlightColor;
    
    if(is_NewRoad == YES){
        [self addRoad:sender];
       
    }
    
    
}

-(void)addRoad:(MKGrid *)sender{
    
    if(roadArray.count == 0){
        
       
        sender.backgroundColor = [UIColor brownColor];
        sender.gridRole = RoadThere;
        sender.moveX = 0;
        sender.moveY = 1;
        sender.moveIndex = 1;
        [sender setImage:nil forState:UIControlStateNormal];
        [roadArray addObject:sender];
        
        [self highlightAvailableRoad:sender];
    }
   
    else if(roadArray.count>0){
        MKGrid *lastGrid = roadArray[roadArray.count-1];
        sender.moveX = lastGrid.moveX = sender.rowX-lastGrid.rowX;
        sender.moveY = lastGrid.moveY = sender.colY-lastGrid.colY;
        if(lastGrid.moveX==1){ sender.moveIndex=lastGrid.moveIndex=3;//右
        }
        else if(lastGrid.moveX==-1){ sender.moveIndex=lastGrid.moveIndex=2;//左
        }
        else if(lastGrid.moveY==1){ sender.moveIndex=lastGrid.moveIndex=1;
        }
        else if(lastGrid.moveY==-1){ sender.moveIndex=lastGrid.moveIndex=0;
        }
        
        if(sender.gridRole==RoadThereAvailable){
            sender.gridRole = RoadThere;
            sender.backgroundColor = [UIColor brownColor];
            [sender setImage:nil forState:UIControlStateNormal];
            [roadArray addObject:sender];
            [self highlightAvailableRoad:sender];

        }
        

    }
    
}

-(BOOL)isAjacentXY:(MKGrid *)GridA andGrid:(MKGrid *)GridB{
    
    
    
    if((abs(GridA.rowX-GridB.rowX)==1 && GridA.colY==GridB.colY)||(abs(GridA.colY-GridB.colY)==1 && GridA.rowX==GridB.rowX)){
        
        return YES;
    }
    
    return NO;
}

-(void)deHightlight{
    
    for (MKGrid *tmpGrid in gridLinearArray) {
        tmpGrid.backgroundColor = gridBackGroundColor;
        if (tmpGrid.gridRole == RoadThereAvailable) {
            tmpGrid.gridRole = EmptyThere;
        }
    }
}

-(void)highlightAvailableRoad:(MKGrid *)sender{
    
    [self deHightlight];
    
    for(int x=-1;x<2;x++){
        for(int y=-1;y<2;y++){
            int setX = x+sender.rowX;
            int setY = y+sender.colY;
            if(setX>=0 && setX<columns && setY>=0 && setY<rows){
                NSLog(@"setX:%d,setY:%d",setX,setY);
                MKGrid *setGrid = gridMatrixArray[setY][setX];
                if([self isAjacentXY:sender andGrid:setGrid] && setGrid.gridRole == EmptyThere){
                setGrid.backgroundColor = highlightColor;
                setGrid.gridRole = RoadThereAvailable;
                }
            }
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//basic view initializing method

-(UIColor *)getColorFromNum:(int) num{
    
    CGFloat nr=num%5+5;
    CGFloat ng=num%5;
    CGFloat nb=num%13%10;
    UIColor *newColor = [UIColor colorWithRed:nr/10 green:1-ng/10 blue:nb/10 alpha:1];
    return newColor;
}

@end
