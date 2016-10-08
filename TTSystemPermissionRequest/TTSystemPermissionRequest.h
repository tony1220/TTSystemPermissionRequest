//
//  TTSystemPermissionRequest.h
//  TTSystemPermissionRequest
//
//  Created by tony1220 on 16/10/8.
//  Copyright © 2016年 tony1220. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationRequestSucessBlock)(BOOL sucess);
@interface TTSystemPermissionRequest : NSObject
/**
 *  判断相机权限
 *
 *  @param sucessBlock 回调
 */
+ (void)judgeAuthorizationWithCamera:(nullable void(^)(BOOL sucess,BOOL isFrist))sucessBlock;
/**
 *  判断定位权限
 *
 *  @param sucessBlock 回调
 */
+ (void)judgeAuthorizationWithLocation:(nullable void(^)(BOOL sucess,BOOL isFrist))sucessBlock;
/**
 *  判断麦克风权限
 *
 *  @param sucessBlock 回调
 */
+ (void)judgeAuthorizationWithMicrophone:(nullable void(^)(BOOL micSucess,BOOL micIsFrist))sucessBlock;
/**
 *  判断相册权限
 *
 *  @param sucessBlock 回调
 */
+ (void)judgeAuthorizationWithGallery:(nullable void(^)(BOOL sucess,BOOL isFrist))sucessBlock;
/**
 *  判断通讯录权限
 *
 *  @param sucessBlock 回调
 */
+ (void)judgeAuthorizationWithContact:(nullable void(^)(BOOL sucess,BOOL isFrist))sucessBlock;
/**
 *  请求相册权限
 *
 *  @param sucessBlock 回调
 */
+ (void)requestAuthorizationWithGallery:(nullable void(^)(BOOL authorSucess))sucessBlock;
/**
 *  请求相机权限
 *
 *  @param sucessBlock 回调
 */
+ (void)requestAuthorizationWithCamera:(nullable void(^)(BOOL authorSucess))sucessBlock;
/**
 *  请求麦克风权限
 *
 *  @param sucessBlock 回调
 */
+ (void)requestAuthorizationWithMicrophone:(nullable void(^)(BOOL authorSucess))sucessBlock;
/**
 *  请求通讯录权限
 *
 *  @param sucessBlock 回调
 */
+ (void)requestAuthorizationWithContact:(nullable void(^)(BOOL authorSucess))sucessBlock;
/**
 *  请求定位权限
 *
 *  @param sucessBlock 回调
 */
- (void)requestAuthorizationWithLocation:(nullable void(^)(BOOL authorSucess))sucessBlock;

@end
