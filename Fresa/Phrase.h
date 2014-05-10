//
//  Phrase.h
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Phrase : NSObject

@property (strong) NSString *original;
@property (strong) NSString *meaning;

- (id)initWithOriginal: (NSString *)original meaning:(NSString *)meaning;

@end
