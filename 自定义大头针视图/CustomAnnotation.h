//
//  CustomAnnotation.h
//  自定义大头针视图
//
//  Created by 张国兵 on 15/8/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.

typedef enum {
    locationinfo=0,
    othersinfo=1
}AnnotationType;
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject<MKAnnotation>{
    
    
}
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *title;
/**
 *  银行
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  大头针坐标
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  用户头像
 */
@property (nonatomic, copy)   NSString*icon;
/**
 *  银行logo
 */
@property (nonatomic, copy)   NSString*bankLogo;
/**
 *  信贷经理唯一标示
 */
@property (nonatomic, copy)   NSString*managerID;
/**
 *  大头针类型
 */
@property(nonatomic,unsafe_unretained)AnnotationType Type;

@end
