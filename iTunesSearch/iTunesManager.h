//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject

@property NSArray *dados;

@property NSMutableArray *filmes;
@property NSMutableArray *musicas;
@property NSMutableArray *ebooks;
@property NSMutableArray *podcasts;


/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (void)buscarMidias:(NSString *)termo;

@end
