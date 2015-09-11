//
//  ViewController.m
//  自定义大头针视图
//
//  Created by 张国兵 on 15/8/24.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "ViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"
#import "CustomAnnotationLocation.h"
#import "CustomAnnotationCurrentLocationView.h"
#import "CustomAnnotationView.h"
#import "CLLocation+Sino.h"
@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>{
    
    MKMapView*_mapView;//地图
    CLLocationManager*_locationManager;//定位
    NSMutableArray *_annotationList;//信贷经理位置
    
}

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    
    if(TARGET_IPHONE_SIMULATOR){
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(39.927446, 116.352288);
        //大头针
        CustomAnnotationLocation *annotation = [[CustomAnnotationLocation alloc] init];
        annotation.address = @"翠峰苑火锅";
        annotation.coordinate=coord;
        
        [_mapView addAnnotation:annotation];
       
    
        
    }else{
        
        [self startLocation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  自定义大头针
     *  一般来说系统的大头针和大头针视图就可以满足我们的基本需求在自定义之前我们先来分析了解一下系统的大头针和大头针视图
     *  先明确大头针和大头针视图的分工，大头针负责存储展示内容，大头针视图负责内容展示的形式，这两者都可以自定义
     *1、 MKPinAnnotationView 原生的，不可以设置image，就算设置也无效
     
      2、 MKAnnotationView 自定义大头针的图片 但是无法设置动画，动画需要自己来实现
     *  如果使用系统原生的那种形式的话用MKPinAnnotationView
     *  如果要简单自定义的使用直接可以用MKAnnotationView的leftCalloutAccessoryView和rightCalloutAccessoryView来实现简单的定制弹出视图的样式
         MKAnnotationView.image 来控制大头针的样式
     *  要是还是不能够满足我们的需求那就要完全自定义了，下面就简单的介绍一下自定义的过程
      3、注意事项在创建大头针的时候一定要包含三个必要信息title、subtitle、coordinate即使你不需要这些属性的话也要添加上否则会你打开大头针视图的canShowCallout属性的时候会崩掉
     *4、存在几种不同的大头针就自定义几种不同的MKAnnotation
     *5、每个大头针对应一个大头针视图定义几个大头针就自定义几个大头针视图，我刚试过用系统的MKAnnotationView通过MKAnnotation的自定义类型来区分设置MKAnnotationView.image只能设置一个样式，没办法保险起见还是几个MKAnnotation对应几个MKAnnotationView；
     *6、总结来说其实自定义大头针视图的用法和我们的tableview的用法极其相似
         * annotation就相当于我们的model
         * annotationView就相当于我们的cell，里面可以完成自定义视图
         * mapview就相当于我们的tableView
     */
    
    self.view.backgroundColor=[UIColor whiteColor];
    //初始话坐标保存数组
    _annotationList = [[NSMutableArray alloc] init];
    //创建一个地图并遵守代理协议
    _mapView=[[MKMapView alloc]initWithFrame:self.view.frame];
    _mapView.delegate=self;
    //是否出现时用户位置，打开属性地图自动居中当前位置
    _mapView.showsUserLocation=YES;
    //设置跟随模式
    _mapView.userTrackingMode = MKUserTrackingModeNone;
    //地图模式,有三种自己command进去看
    [_mapView setMapType:MKMapTypeStandard];
    [self.view addSubview:_mapView];
    
    [self getData];
   
 
}
#pragma mark-模拟网络数据
-(void)getData{
    
    NSArray*tempArr=@[
                      @{@"latitude":@"116.342178",@"longitude":@"39.947246",@"managerID":@"1",@"name":@"张经理",@"bank":@"中信银行",@"icon":@"t012d74cb93b9648729",@"bankLogo":@"logo2"},
                      @{@"latitude":@"116.327167",@"longitude":@"39.976996",@"managerID":@"2",@"name":@"刘经理",@"bank":@"中国银行",@"icon":@"t016a1b59d7bcd6cc2f",@"bankLogo":@"logo1"},
                      @{@"latitude":@"116.332171",@"longitude":@"39.957246",@"managerID":@"3",@"name":@"孙经理",@"bank":@"农商银行",@"icon":@"t016a1b59d7bcd6cc2f",@"bankLogo":@"logo2"},
                      @{@"latitude":@"116.322148",@"longitude":@"39.967246",@"managerID":@"4",@"name":@"李经理",@"bank":@"浦发银行",@"icon":@"t012d74cb93b9648729",@"bankLogo":@"logo1"}
                      ];
    [_annotationList addObjectsFromArray:tempArr];
    
    [self setAnnotionsWithList:_annotationList];
    
    
    
}
-(void)setAnnotionsWithList:(NSMutableArray *)list
{
    for(NSDictionary*dic in list){
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([dic[@"longitude"]doubleValue], [dic[@"latitude"]doubleValue]);
        //放大倍数
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        //生成定位显示
        MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
        //筛选坐标
        if (region.center.latitude>90||region.center.longitude>180) {
            continue;
        }
        
        //确定位置
        [_mapView setRegion:region];
        
        //大头针
        CustomAnnotation *annotation = [[CustomAnnotation alloc] init];
        annotation.coordinate = coord;
        annotation.title = dic[@"name"];
        annotation.subtitle = dic[@"bank"];
        annotation.managerID=dic[@"managerID"];
        annotation.bankLogo=dic[@"bankLogo"];
        annotation.icon=dic[@"icon"];
        annotation.Type=othersinfo;
        [_mapView addAnnotation:annotation];
        
        
    };
    
}
#pragma mark-视图定制
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString* ID_One = @"MKAnnotationView_one";
    static NSString* ID_Two = @"MKAnnotationView_two";

    //用户当前位置
    if([annotation isKindOfClass:[CustomAnnotationLocation class]]){
         CustomAnnotationLocation*tempAnnotation=(CustomAnnotationLocation*)annotation;
        CustomAnnotationCurrentLocationView*annotationView=(CustomAnnotationCurrentLocationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:ID_One];
        //如果没有就创建
        if (!annotationView){
            annotationView=[[CustomAnnotationCurrentLocationView alloc]initWithAnnotation:annotation reuseIdentifier:ID_One];
        }
        [annotationView setDataWithAnnotation:tempAnnotation];
        return annotationView;
        
        
    }//其他信息位置
    else if([annotation isKindOfClass:[CustomAnnotation class]]){
       CustomAnnotation*tempAnnotation=(CustomAnnotation*)annotation;
        CustomAnnotationView*annotationView=(CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:ID_Two];
        //如果没有就创建
        if (!annotationView) {
            annotationView=[[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID_Two];
        }
        
        [annotationView setDataWithAnnotation:tempAnnotation];
        [annotationView setDidSelectBlock:^(NSString *managerID) {
            
            NSLog(@"%@",managerID);
            
        }];
        return annotationView;
        
    }
    
    return nil;
}
#pragma mark--定位服务
-(void)startLocation{
    
    NSLog(@"开始定位");
    
    if(![CLLocationManager locationServicesEnabled]){
        
        NSLog(@"定位不可用");
        
        
    }else{
        
        _locationManager =[[CLLocationManager alloc]init];
        _locationManager.delegate=self;
        if([[UIDevice currentDevice].systemVersion floatValue]>=8){
            
            [_locationManager requestWhenInUseAuthorization];
            
        }
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        [_locationManager startUpdatingLocation];
        
    }
    
}
#pragma mark-locationManager Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //位置信息
    CLLocation*location=manager.location;
    CLLocationCoordinate2D coordinate=location.coordinate;
    //显示坐标
    NSLog(@"经度：%f,纬度：%f",coordinate.longitude,coordinate.latitude);
    [_locationManager stopUpdatingLocation];
    _locationManager=nil;
    NSLog(@"定位结束");
    //获取火星坐标
    CLLocation*mars_location=[location locationMarsFromEarth];
    //反编码->根据坐标获取位置详情
    CLGeocoder*aaa=[[CLGeocoder alloc]init];
    [aaa reverseGeocodeLocation:mars_location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark*placemark=[placemarks firstObject];
        NSString*location= placemark.addressDictionary[@"Name"];
        //大头针
        CustomAnnotationLocation *annotation = [[CustomAnnotationLocation alloc] init];
        annotation.address = location;
        annotation.coordinate=coordinate;
        [_mapView selectAnnotation:annotation animated:YES];
        [_mapView addAnnotation:annotation];
        _mapView.centerCoordinate = mars_location.coordinate;
        
        
    }];
    
}
#pragma mark-取消选中
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    NSLog(@"取消选中");
    
}
#pragma mark-选中
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
 
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
    
}
#pragma mark-更新用户位置
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"更新用户数据");
}
#pragma mark-改变跟随模式
-(void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
