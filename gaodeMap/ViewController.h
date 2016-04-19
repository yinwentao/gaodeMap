//
//  ViewController.h
//  gaodeMap
//
//  Created by 尹文涛 on 16/3/21.
//  Copyright © 2016年 小木科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

