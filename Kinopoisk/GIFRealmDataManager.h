//
//  GIFRealmDataManager.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//
#import "Realm/Realm.h"
#import "GIFModel.h"

@interface GIFRealmDataManager : NSObject

@property (nonatomic, strong) RLMRealm *realm;

- (RLMResults<GIFModel *> *) getAll;
- (GIFModel *) getModel: (NSInteger) row;
- (void) deleteAll;
- (void) addModel: (GIFModel *) model;

@end
