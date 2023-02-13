//
//  PermissionManager.m
//  flutter_plugin_permissions
//
//  Created by 王贺天 on 2018/11/24.
//

#import "PermissionManager.h"

@implementation PermissionManager

+ (void) checkPermissionStatus:(PermissionGroupType) permission result:(FlutterResult)result
{
    PermissionStrategy *permissionStrategy = [PermissionManager createPermissionStrategy:permission];
    PermissionStatusType permissionStatusType = [permissionStrategy checkPermissionStatus:permission];
    result([NSString stringWithFormat:@"\"%@\"", [PermissionStatus permissionStatusToStr:permissionStatusType]]);
}
+ (void) openAppSettings:(FlutterResult)result
{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            result([NSNumber numberWithBool:success]);
        }];
    }else {
        BOOL completion = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        result([NSNumber numberWithBool:completion]);
    }
}
- (void) requestPermissions:(NSMutableArray<NSNumber *>*) permissions completion:(PermissionRequestCompletion)completion
{
    for (NSNumber *permission in permissions) {
        PermissionGroupType permissionType =permission.integerValue;
        PermissionStrategy *permissionStrategy = [PermissionManager createPermissionStrategy:permissionType];
        [permissionStrategy requestPermission:(permissionType) completionHandler:^(PermissionStatusType statusType) {
            completion([[NSDictionary alloc] initWithObjectsAndKeys:[PermissionStatus permissionStatusToStr:(statusType)], [PermissionGroup permissionGroupToStr:permissionType], nil]);
        }];
    }
    
}

+ (PermissionStrategy *) createPermissionStrategy: (PermissionGroupType) permission
{
    switch (permission) {


            
        case PermissionGroupPhotos:
            return [[PhotoPermissionStrategy alloc] init];
            break;
            

        case PermissionGroupLocation:
        case PermissionGroupLocationAlways:
        case PermissionGroupLocationWhenInUse:
            return [[LocationPermissionStrategy alloc] init];
            break;


            
        default:
            return [[UnknownPermissionStrategy alloc] init];
            break;
    }
}

@end
