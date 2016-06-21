//
//  JHClassesPageResponseModel.h
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/6/1.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JHClassesPageResponseModel <NSObject>
@end
// 返回我的班级列表中的school,api/http/v3/getSchoolClassForumList.aspx
@interface JHClassesPageResponseModel : NSObject
@property (nonatomic, copy) NSString *classID;//板块id
@property (nonatomic, copy) NSString *name;//板块名称
@property (nonatomic, copy) NSString *management;//版块管理员uid用逗号隔开，如“1,2,3”
@end
