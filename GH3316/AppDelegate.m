//
//  AppDelegate.m
//  GH3316
//
//  Created by JP Simard on 3/11/16.
//  Copyright © 2016 Realm. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>

NSInteger const kDatabaseVersion = 1;

@interface Pair : RLMObject
@property int left;
@property int right;
@end
@implementation Pair
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureDatabase];

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    Pair *pair = [[Pair alloc] init];
    pair.left = 0;
    pair.right = 1;
    [realm addObject:pair];
    [realm commitWriteTransaction];

    NSLog(@"all pairs: %@", [Pair allObjects]);
    return YES;
}

- (void)configureDatabase {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = kDatabaseVersion;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {

        if (oldSchemaVersion < kDatabaseVersion) {}
    };

    [RLMRealmConfiguration setDefaultConfiguration:config];

    [RLMRealm defaultRealm];
}

@end
