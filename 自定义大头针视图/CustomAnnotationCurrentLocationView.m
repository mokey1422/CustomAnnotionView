//
//  CustomAnnotationCurrentLocationView.m
//  自定义大头针视图
//
//  Created by 张国兵 on 15/8/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//
#define AnnotationViewStandardWidth     100.0f
#define AnnotationViewStandardHeight    50.0f
#define AnnotationViewVerticalOffset    34.0f
#import "CustomAnnotationCurrentLocationView.h"

@implementation CustomAnnotationCurrentLocationView
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.canShowCallout = YES;
        self.userInteractionEnabled=YES;
        self.frame = CGRectMake(0, 0, AnnotationViewStandardWidth, AnnotationViewStandardHeight);
        self.centerOffset = CGPointMake(0, -AnnotationViewVerticalOffset);
        [self createUI];
    }
    return self;
}
#pragma mark-创建UI
-(void)createUI{
    self.bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, AnnotationViewStandardWidth, AnnotationViewStandardHeight)];
    self.bgImageView.image=[UIImage imageNamed:@"popup-bg-copy"];
    [self addSubview:self.bgImageView];
    self.locationLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 90, 20)];
    self.locationLabel.text=@"我在:翠峰苑火锅";
    self.locationLabel.textColor=[UIColor whiteColor];
    self.locationLabel.font=[UIFont systemFontOfSize:12];
    self.locationLabel.adjustsFontSizeToFitWidth=YES;
    [self.bgImageView addSubview:self.locationLabel];
    
    

}
#pragma mark-设置
-(void)setDataWithAnnotation:(CustomAnnotationLocation *)annotation{
    
     self.locationLabel.text=[@"我在:"stringByAppendingString:annotation.address];
    
}
#pragma mark-选中居中
- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView {

  
}
@end
