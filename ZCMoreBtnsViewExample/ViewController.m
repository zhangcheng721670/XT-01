//
//  ViewController.m
//  ZCMoreBtnsViewExample
//
//  Created by zhangcheng on 16/8/12.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ViewController.h"
#import "ZCMoreBtnsView.h"
@interface ViewController ()<ZCMoreBtnsViewDeleaget,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *rowTitleRrray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rowTitleRrray=@[@"From the left",
                         @"From the right",
                         @"From the upper",
                         @"From the lower",
                         
                         @"From the lower left corner",
                         @"From the lower right corner",
                         @"From the upper left corner",
                         @"From the upper right corner",
                         ];
    
    UITableView*tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 300, 400) style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TitlesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    //
    cell.textLabel.text=self.rowTitleRrray[indexPath.row];
    //
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickBtn:indexPath.row];
}
- (void)clickBtn:(NSInteger)index {
    ZCMoreBtnsView *moreView=[[ZCMoreBtnsView alloc]initWithFrame:[[UIScreen mainScreen] bounds] AndTitlesArray:@[ @[ @"apple", @"orange" ], @[ @"car" ], @[ @"ship" ] ] AndImages:nil AndTableViewSize:CGSizeMake(150, 180) AndAnchorPoint:CGPointMake(150, 200) AndAniamtion:YES AndPopupDirection:index AndNeedScale:YES];
    moreView.rowHeight = 30;
    moreView.delegate=self;
    [self.view addSubview:moreView];
    [moreView showMoreBtns];
}
-(void)ZC_tableviewCliekedIndexPath:(NSIndexPath *)indexpath
{
    NSLog(@"%@",indexpath);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
