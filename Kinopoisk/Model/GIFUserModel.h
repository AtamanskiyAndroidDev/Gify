//
//  GIFUserModel.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Realm/Realm.h>

@interface GIFUserModel : RLMObject

@property NSString *userId;
@property NSString *userName;
@property NSString *avatarUrl;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<GIFUserModel>
RLM_ARRAY_TYPE(GIFUserModel)
