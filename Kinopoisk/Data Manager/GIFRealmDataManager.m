//
//  GIFRealmDataManager.m
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIFRealmDataManager.h"
#import "Realm/Realm.h"
#import "GIFModel.h"

@interface GIFRealmDataManager ()
//
//{
//    RLMRealm *realm;
//}

@end

@implementation GIFRealmDataManager

- (id)init
{
    _realm = [RLMRealm defaultRealm];
    return self;
}

- (void)addModel:(GIFModel *)model
{
    [_realm transactionWithBlock:^{
        [_realm addOrUpdateObject:model];
        [_realm commitWriteTransaction];
    }];
}

- (void)deleteAll
{
    RLMResults<GIFModel *> *allModel = [GIFModel allObjects];
    [_realm transactionWithBlock:^{
        [_realm deleteObjects:allModel];
    }];
}

- (GIFModel *)getModel:(NSInteger)row
{
    const RLMResults<GIFModel *> *allModel = [GIFModel allObjects];
    return allModel[row];
}

- (RLMResults<GIFModel *> *)getAll
{
    RLMResults<GIFModel *> *allModel = [GIFModel allObjects];
    return allModel;
}

@end
