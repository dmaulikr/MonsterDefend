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
    NSMutableArray *gridArray;
    NSMutableArray *monsterArray;
    NSMutableArray *roadArray;
    NSMutableArray *towerArray;
    NSMutableArray *monsterImageArray;
    BOOL is_NewRoad;
    
    
    
    //用于保存各类共享的全局变量的对象
    MKAppRecord *appRecord;
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
    gridWidth = (screenWidth - leftSpace-rightSpace)/columns-(gridSpace*columns)/(columns-1);
    gridHeight = (screenHeight - topSpace - bottomSpace)/rows - (gridSpace*rows)/(rows-1);
    
    //全局对象初始化
    gridArray = [[NSMutableArray alloc]init];
    monsterArray = [[NSMutableArray alloc]init];
    roadArray = [[NSMutableArray alloc]init];
    towerArray = [[NSMutableArray alloc]init];
    monsterImageArray = [[NSMutableArray alloc]init];
    appRecord = [[MKAppRecord alloc]init];
    appRecord.gridArray = gridArray;
    appRecord.monsterArray = monsterArray;
    appRecord.roadArray = roadArray;
    appRecord.towerArray = towerArray;
    [self initMonsterPicture];
    appRecord.monsterImageArray = monsterImageArray;
    
    
    
    //初始化主视图
    self.view.backgroundColor = mainBackGroundColor;
    for(int i = 0;i<columns;i++){
        NSMutableArray *viewRow;
        viewRow = [[NSMutableArray alloc]init];
        for (int j = 0 ; j<rows; j++) {
            MKGrid *newGrid = [[MKGrid alloc]init];
            newGrid.frame = CGRectMake(leftSpace+gridWidth*i+gridSpace*i, topSpace+gridHeight*j+gridSpace*j, gridWidth, gridHeight);
            newGrid.backgroundColor = gridBackGroundColor;
            [newGrid setImage:[UIImage imageNamed:@"Picture/grass.png"] forState:UIControlStateNormal];
            newGrid.rowX = j;
            newGrid.colY = i;
            newGrid.width=gridWidth;
            newGrid.height=gridHeight;
            // [newGrid setTitle:[NSString stringWithFormat:@"x%dy%d",j,i] forState:UIControlStateNormal];
            
            //设置grid触发事件，可选,###注意，其中action调用的方法gridTouchAtion的默认参数就是newGrid!
            [newGrid addTarget:self action:@selector(gridTouchAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //将grid加入控制数组和view中
            [viewRow addObject:newGrid];
            [self.view addSubview:newGrid];
        }
        [gridArray addObject:viewRow];
    }
    
    
    
    
    //视图中grid的控制数组测试
    //    MKGrid *tmpGrid = gridArray[3][0];
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
    [newRoadButton addTarget:self action:@selector(newRoadFlag) forControlEvents:UIControlEventTouchUpInside];
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
    [startGameButton addTarget:self action:@selector(startGameEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startGameButton];
    
    
}

//开始游戏
-(void)startGameEvent{
    
    
    MKMonster *newMonster = [[MKMonster alloc]initWithAppRecord:appRecord];
    [monsterArray addObject:newMonster];
    
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
    [self restartGridArray];
    [appRecord roadRecordImport:roadArray andFileName:readPath];
    
    
    
    NSLog(@"roadArray.count:%lu",roadArray.count);
    for(MKGrid *tmpGrid in roadArray){
        tmpGrid.backgroundColor = [UIColor brownColor];
        tmpGrid.gridRole = RoadThere;
    }
}

//重置主视图
-(void)restartGridArray{
    
    [roadArray removeAllObjects];
    
    for(NSMutableArray *tmpArray in gridArray){
        for(MKGrid *tmpGrid in tmpArray){
            tmpGrid.backgroundColor = [UIColor grayColor];
            [tmpGrid setImage:[UIImage imageNamed:@"Picture/grass.png"] forState:UIControlStateNormal];
            tmpGrid.gridRole = EmptyThere;
        }
    }
}
//保存生成的路
-(void)saveRoad{
    
    [appRecord roadRecordSave:roadArray andFileName:@"roadArray.plist"];
}

//新建路功能的开启和关闭
-(void)newRoadFlag{
    if(is_NewRoad == NO){
        is_NewRoad = YES;
        [self restartGridArray];
    }
    else{
        is_NewRoad = NO;
    }
}

//grid触发事件的调用方法
-(void)gridTouchAction:(MKGrid *)sender{
    if(is_NewRoad == YES){
        [self addRoad:sender];
        
    }
    
    
}

-(void)addRoad:(MKGrid *)sender{
    
    if(roadArray.count == 0){
        sender.backgroundColor = [UIColor brownColor];
        [sender setImage:nil forState:UIControlStateNormal];
        [roadArray addObject:sender];}
    else if(roadArray.count==1){
        MKGrid *lastGrid = roadArray[roadArray.count-1];
        bool is_AjacentX = (sender.colY == lastGrid.colY && ((sender.rowX == lastGrid.rowX+1) || (sender.rowX == lastGrid.rowX-1)));
        bool is_AjacentY = (sender.rowX == lastGrid.rowX && ((sender.colY == lastGrid.colY+1) || (sender.colY == lastGrid.colY-1)));
        if(is_AjacentX || is_AjacentY){
            
            sender.backgroundColor = [UIColor brownColor];
            [sender setImage:nil forState:UIControlStateNormal];
            [roadArray addObject:sender];
        }
    }
    else if(roadArray.count>1){
        MKGrid *lastGrid = roadArray[roadArray.count-1];
        bool is_AjacentX = (sender.colY == lastGrid.colY && ((sender.rowX == lastGrid.rowX+1) || (sender.rowX == lastGrid.rowX-1)));
        bool is_AjacentY = (sender.rowX == lastGrid.rowX && ((sender.colY == lastGrid.colY+1) || (sender.colY == lastGrid.colY-1)));
        
        MKGrid *preLastGrid = roadArray[roadArray.count-2];
        bool is_Duplicat = (sender.rowX==preLastGrid.rowX && sender.colY == preLastGrid.colY);
        if((is_AjacentX || is_AjacentY)&&!is_Duplicat){
            
            sender.backgroundColor = [UIColor brownColor];
            [sender setImage:nil forState:UIControlStateNormal];
            [roadArray addObject:sender];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
