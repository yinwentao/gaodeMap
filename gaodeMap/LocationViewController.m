//
//  LocationViewController.m
//  gaodeMap
//
//  Created by 尹文涛 on 16/3/22.
//  Copyright © 2016年 小木科技. All rights reserved.
//

#import "LocationViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface LocationViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    
    UILabel *_centerLocationLabel;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //配置用户Key
    [MAMapServices sharedServices].apiKey = mapKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64-49)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    // 获取中心点坐标
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 20)];
    view.backgroundColor  = [UIColor redColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    _centerLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94, 200 , 80)];
    _centerLocationLabel.numberOfLines = 3;
    _centerLocationLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_centerLocationLabel];
    
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            
        NSLog(@"可以定位");
            
    }else{
        NSLog(@"请允许定位");
    }
    

    
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    static int i=0;
    i++;
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"第%d次返回latitude : %f,longitude: %f",i,userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    
    NSLog(@"当前的中心点位置：%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    
    _centerLocationLabel.text = [NSString stringWithFormat:@"中心点位置：\nlatitude：%f \nlongitude:%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"失败原因%@",error);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
