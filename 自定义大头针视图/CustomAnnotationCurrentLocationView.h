//
//  CustomAnnotationCurrentLocationView.h
//  自定义大头针视图
//
//  Created by 张国兵 on 15/8/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.

#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "CustomAnnotationLocation.h"
@interface CustomAnnotationCurrentLocationView : MKAnnotationView{
    

}
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel*locationLabel;
@property (nonatomic, retain) CustomAnnotationLocation*annotationInfo;
-(void)setDataWithAnnotation:(CustomAnnotationLocation*)annotation;
@end
