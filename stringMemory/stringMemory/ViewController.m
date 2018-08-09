//
//  ViewController.m
//  stringMemory
//
//  Created by chenchuang on 2018/7/31.
//  Copyright © 2018年 app. All rights reserved.
//
#define WinW [UIScreen mainScreen].bounds.size.width
#define WinH [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <mach/mach.h>//用于打印内存

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *showTimeL;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic ,assign) NSInteger selectBtnTag;

@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.title = @"字符串初始化测试";
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"第一种：[[NSString alloc] initWithString:@\"abccc\"]",
                      @"第二种：@\"abcc\"",
                      @"第三种：[[NSString alloc] init]",
                      @"第四种：[[NSString alloc] initWithCString:@\"abcc\"]",
                      @"第五种：[NSString stringWithString:@\"abcc\"]",
                      @"第六种：[NSString stringWithFormat:@\"abcc\"]",
                      @"第七种：char a[]=\"abcc\"",
                      @"第八种：[[NSString alloc] initWithFormat:@\"abcc\"]",
                      @"第九种：char a[32],sprintf(a,\"abcc\")",
                      @"第十种：[[NSMutableString alloc] init]",
                      nil];
    
    [self setUI];
}


- (void)setUI{
    
    _showTimeL = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, WinW, 40)];
    _showTimeL.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _showTimeL.textColor = [UIColor redColor];
    _showTimeL.text = @"";
    [self.view addSubview:_showTimeL];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, WinW,WinH-64-40)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellddddddID";
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableCell==nil) {
        tableCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    tableCell.textLabel.text = self.dataArray[indexPath.row];
    tableCell.textLabel.numberOfLines = 0;
    tableCell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    return tableCell;
    
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _showTimeL.text = @"";
    [self clickAction:indexPath.row+100];
}

- (void)clickAction:(NSInteger)row
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    int testi;
    int testnum=10;
    int i,n = 1000000;
    float c,tm=0.0;
    
    switch (row) {
        case 100:
        {
            for(testi=0;testi<testnum;testi++){
                
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *t=[[NSString alloc] initWithString:@"abccc"];
                    //[t release];//内存基本稳定不变
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 101:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *astring = @"abcc";
                    //[astring release]; //内存基本稳定不变
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 102:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *astring = [[NSString alloc] init];
                    astring = @"abcc";
                    //[astring release];//内存基本稳定不变
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 103:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    char *Cstring = "abcc";
                    NSString *astring = [[NSString alloc] initWithCString:Cstring];
                    //[astring release];//内存基本稳定不变
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 104:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *a=[NSString stringWithString:@"abcc"];
                    //[a release];//内存增长过快
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 105:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *a=[NSString stringWithFormat:@"abcc%d",i];
                   // [a release]; //太长时间，内存增长过快
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 106:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    char a[]="abcc";// 内存基本稳定不变
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 107:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSString *a=[[NSString alloc] initWithFormat:@"abcc%d",i];
                    //[a release];//内存有增长.较耗时
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
        case 108:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    char a[32];
                    sprintf(a,"abcc%d",i);
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
                
            }
        }
            break;
        case 109:
        {
            for(testi=0;testi<testnum;testi++){
                NSDate *beg=[NSDate date];
                for(i=0;i<n;i++){
                    NSMutableString *a=[[NSMutableString alloc] init];
                    [a stringByAppendingFormat:@"abcc%d",i];
                    //[a release];//内存爆长.非常耗时
                }
                c=[[NSDate date] timeIntervalSinceDate:beg];
                tm+=c;
                NSLog(@"navg%d======%f",testi,c);
            }
        }
            break;
            
        default:
            break;
    }
    
    _showTimeL.text = [NSString stringWithFormat:@"耗时==%f; %@",(float)tm/testnum,[self report_memory]];
    NSLog(@"showTimeL.text======%@", _showTimeL.text);
    [pool release];
}

//获取当前任务所占用内存
-(NSString *)report_memory{
    
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return @"没有成功";
    }
    
    return [NSString stringWithFormat:@"内存：%fM",taskInfo.resident_size / 1024.0 / 1024.0];
    
}

@end
