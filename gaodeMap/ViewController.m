//
//  ViewController.m
//  gaodeMap
//
//  Created by 尹文涛 on 16/3/21.
//  Copyright © 2016年 小木科技. All rights reserved.
//

#import "ViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController ()<AMapSearchDelegate>
{
    AMapSearchAPI *_search;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //配置用户Key
    [AMapSearchServices sharedServices].apiKey = mapKey;
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    
//    [self myFunction];

}

- (void) myFunction{
    NSMutableArray *oriArr = [[NSMutableArray alloc] initWithCapacity:100];
    for (int i=0; i<500; i++) {
        [oriArr addObject:@"0"];// down
    }
    for (int i=500; i<1000; i++) {
        [oriArr addObject:@"1"];// up
    }
    
    for (int i = 0; i<1000000000; i++) {
        int x = arc4random() % 1000;
        NSString *value = oriArr[x];
        
        if (value.integerValue) {
            // 正面就再抛一次
            int y = arc4random() % 2;
            if (y>0) {
                oriArr[x] = @"1";
            }else{
                oriArr[x] = @"0";
            }
            
        }else{
            // 反面就翻正
            oriArr[x] = @"1";
        }
    }
    
    // 结果
    NSInteger count = 0;
    for (NSString *item in oriArr) {
        if (item.integerValue) {
            count++;
        }
    }
    NSLog(@"正面比反面%d : %d",count,oriArr.count-count);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text
                             stringByReplacingCharactersInRange:range withString:string];
    //构造AMapInputTipsSearchRequest对象，设置请求参数
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = toBeString;
//    tipsRequest.city = @"北京";
    
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %d", response.count];
    NSString *strtips = @"";
    for (AMapTip *p in response.tips) {
        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
    NSLog(@"InputTips: %@", result);
    
    _dataSource = [NSMutableArray arrayWithArray:response.tips];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serchClick:(id)sender {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    
    AMapTip *tip = _dataSource[indexPath.row];
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.district;
    
    return cell;
}


@end
