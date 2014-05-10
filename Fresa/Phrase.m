//
//  Phrase.m
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "Phrase.h"

@implementation Phrase

- (id)initWithOriginal: (NSString *)original meaning:(NSString *)meaning
{
    self = [super init];

    self.original = original;
    self.meaning = meaning;

    return self;
}

@end
