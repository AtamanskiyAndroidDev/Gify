//
//  GIFModel.h
//  Kinopoisk
//
//  Created by sasha ataman on 14.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <Realm/Realm.h>
#import "GIFUserModel.h"

@interface GIFModel : RLMObject

@property NSString *id;
@property NSString *slug;
@property NSString *originalImage;
@property NSString *date;

@property GIFUserModel *user;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<GIFModel>
RLM_ARRAY_TYPE(GIFModel)
