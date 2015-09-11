//
//  CustomAnnotationLocation.h
//  自定义大头针视图
//
//  Created by 张国兵 on 15/8/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotationLocation : NSObject<MKAnnotation>
/**
 *  主标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  副标题
 */
@property (nonatomic, copy) NSString *subtitle;
/**
 *  大头针坐标
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  地址（私有变量）
 */
@property (nonatomic, copy) NSString *address;
@end
