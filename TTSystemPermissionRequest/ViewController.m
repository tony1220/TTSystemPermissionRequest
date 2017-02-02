//
//  ViewController.m
//  TTSystemPermissionRequest
//
//  Created by tony1220 on 16/10/8.
//  Copyright © 2016年 tony1220. All rights reserved.
//

#import "ViewController.h"
#import "TTSystemPermissionRequest.h"
@interface ViewController ()

@property (nonatomic,strong) TTSystemPermissionRequest *locationRequest;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)requestButtonPressed:(UIButton *)sender {
    switch (sender.tag - 10) {
        case 0:
        {
            [TTSystemPermissionRequest judgeAuthorizationWithCamera:^(BOOL sucess, BOOL isFrist) {
                if (isFrist) {
                    [TTSystemPermissionRequest requestAuthorizationWithCamera:^(BOOL authorSucess) {
                        if (authorSucess) {
                            NSLog(@"请求相机权限成功");
                        }
                    }];
                }
            }];
        }
            break;
        case 1:
        {
            [TTSystemPermissionRequest judgeAuthorizationWithGallery:^(BOOL sucess, BOOL isFrist) {
                if (isFrist) {
                    [TTSystemPermissionRequest requestAuthorizationWithGallery:^(BOOL authorSucess) {
                        if (authorSucess) {
                            NSLog(@"请求相册权限成功");
                        }
                        else {
                            NSLog(@"请求相册权限失败");
                        }
                    }];
                }
            }];
        }
            break;
        case 2:
        {
            [TTSystemPermissionRequest judgeAuthorizationWithContact:^(BOOL sucess, BOOL isFrist) {
                if (isFrist) {
                    [TTSystemPermissionRequest requestAuthorizationWithContact:^(BOOL authorSucess) {
                        if (authorSucess) {
                            NSLog(@"请求通讯录权限成功");
                        }
                    }];
                }
            }];
        }
            break;
        case 3:
        {
            [TTSystemPermissionRequest judgeAuthorizationWithMicrophone:^(BOOL micSucess, BOOL micIsFrist) {
                if (micIsFrist) {
                    [TTSystemPermissionRequest requestAuthorizationWithMicrophone:^(BOOL authorSucess) {
                        if (authorSucess) {
                            NSLog(@"请求麦克风权限成功");
                        }
                    }];
                }
            }];
        }
            break;
        case 4:
        {
            self.locationRequest = [[TTSystemPermissionRequest alloc]init];
            [TTSystemPermissionRequest judgeAuthorizationWithLocation:^(BOOL sucess, BOOL isFrist) {
                if (isFrist) {
                    [self.locationRequest requestAuthorizationWithLocation:^(BOOL authorSucess) {
                        if (authorSucess) {
                            NSLog(@"请求定位权限成功");
                        }
                    }];
                }
            }];
        }
            break;
        default:
            break;
    }
}


@end
