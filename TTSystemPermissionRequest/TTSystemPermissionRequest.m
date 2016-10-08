//
//  TTSystemPermissionRequest.m
//  TTSystemPermissionRequest
//
//  Created by tony1220 on 16/10/8.
//  Copyright © 2016年 tony1220. All rights reserved.
//

#import "TTSystemPermissionRequest.h"
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface TTSystemPermissionRequest ()<CLLocationManagerDelegate>

@property (nonatomic,retain) CLLocationManager *locationManager;

@property (nonatomic,copy) LocationRequestSucessBlock locationRequestSucessBlock;

@property (nonatomic,assign) NSInteger locationCount;

@end

@implementation TTSystemPermissionRequest


#pragma mark --查看相机权限
+ (void)judgeAuthorizationWithCamera:(void (^)(BOOL, BOOL))sucessBlock
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted){
        if (sucessBlock) {
            sucessBlock(NO,NO);
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined){
        if (sucessBlock) {
            sucessBlock(NO,YES);
        }
    }
    else {
        if (sucessBlock) {
            sucessBlock(YES,NO);
        }
    }
}

#pragma mark --查看定位权限
+ (void)judgeAuthorizationWithLocation:(void (^)(BOOL, BOOL))sucessBlock
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) )
    {
        if (sucessBlock) {
            sucessBlock(YES,NO);
        }
    }
    else if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        if (sucessBlock) {
            sucessBlock(NO,YES);
        }
    }
    else {
        if (sucessBlock) {
            sucessBlock(NO,NO);
        }
    }
}

#pragma mark --查看麦克风权限
+ (void)judgeAuthorizationWithMicrophone:(void (^)(BOOL, BOOL))sucessBlock
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted){
        if (sucessBlock) {
            sucessBlock(NO,NO);
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined){
        if (sucessBlock) {
            sucessBlock(NO,YES);
        }
    }
    else {
        if (sucessBlock) {
            sucessBlock(YES,NO);
        }
    }
}

#pragma mark --查看相册权限
+ (void)judgeAuthorizationWithGallery:(void (^)(BOOL, BOOL))sucessBlock
{
    if ([UIDevice currentDevice].systemVersion.integerValue >= 8) {
        PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
        if (author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied){
            if (sucessBlock) {
                sucessBlock(NO,NO);
            }
        }
        else if (author == PHAuthorizationStatusNotDetermined){
            if (sucessBlock) {
                sucessBlock(NO,YES);
            }
        }
        else {
            if (sucessBlock) {
                sucessBlock(YES,NO);
            }
        }
    }
    else {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
            if (sucessBlock) {
                sucessBlock(NO,NO);
            }
        }
        else if (author == ALAuthorizationStatusNotDetermined){
            if (sucessBlock) {
                sucessBlock(NO,YES);
            }
        }
        else {
            if (sucessBlock) {
                sucessBlock(YES,NO);
            }
        }
    }
  
}

#pragma mark --查看通讯录权限
+ (void)judgeAuthorizationWithContact:(void (^)(BOOL, BOOL))sucessBlock
{
    if ([UIDevice currentDevice].systemVersion.integerValue >= 9) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusAuthorized ) {
            if (sucessBlock) {
                sucessBlock(YES,NO);
            }
        }
        else if (status == CNAuthorizationStatusNotDetermined){
            if (sucessBlock) {
                sucessBlock(NO,YES);
            }
        }
        else {
            if (sucessBlock) {
                sucessBlock(NO,NO);
            }
        }
    }
    else {
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            if (sucessBlock) {
                sucessBlock(YES,NO);
            }
        }
        else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined){
            if (sucessBlock) {
                sucessBlock(NO,YES);
            }
        }
        else {
            if (sucessBlock) {
                sucessBlock(NO,NO);
            }
        }
    }
    
    
}

#pragma mark --请求相机权限
+ (void)requestAuthorizationWithCamera:(void (^)(BOOL))sucessBlock
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sucessBlock) {
                sucessBlock(granted);
            }
        });
        
    }];
}

#pragma mark --请求通讯录权限
+ (void)requestAuthorizationWithContact:(void (^)(BOOL))sucessBlock
{
    if ([UIDevice currentDevice].systemVersion.integerValue >= 9) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sucessBlock) {
                    sucessBlock(granted);
                }
            });
        }];
    }
    else {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (sucessBlock) {
                    sucessBlock(granted);
                }
            });
            
        });
    }
  
}

#pragma mark --请求相册权限
+ (void)requestAuthorizationWithGallery:(void (^)(BOOL))sucessBlock
{
    if ([UIDevice currentDevice].systemVersion.integerValue >= 8) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized)
            {
                sucessBlock(YES);
            }
            else {
                sucessBlock(NO);
            }
        }];
    }
    else {
        __block NSInteger count;
        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            count = count + 1;
            if (count == 1) {
               sucessBlock(YES);
            }
        } failureBlock:^(NSError *error) {
            sucessBlock(NO);
        }];
    }
}

#pragma mark --请求定位权限
- (void)requestAuthorizationWithLocation:(void (^)(BOOL))sucessBlock
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    CLLocationDistance distance=10.0;
    self.locationManager.distanceFilter=distance;
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if (sucessBlock) {
        self.locationRequestSucessBlock = sucessBlock;
    }
    self.locationCount = 0;
    [self.locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    self.locationCount = self.locationCount + 1;
    if (self.locationCount == 1) {
        self.locationRequestSucessBlock(YES);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.locationRequestSucessBlock(NO);
}

#pragma mark --请求麦克风权限
+ (void)requestAuthorizationWithMicrophone:(void (^)(BOOL))sucessBlock
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sucessBlock) {
                sucessBlock(granted);
            }
        });
    }];
}

@end
