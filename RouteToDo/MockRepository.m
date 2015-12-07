//
//  MockRepository.m
//  RouteToDo
//
//  Created by Gabriel Gayan on 15/24/11.
//  Copyright © 2015 RouteToDo. All rights reserved.
//

#import "MockRepository.h"
#import "mocks.h"

@implementation MockRepository

#pragma mark - Categories

- (void)allCategoriesWithCompletion:(void (^)(NSArray *categories, NSError *error))completion {
    completion(@[], nil);
}

#pragma mark - Home routes

- (void)trendingRoutesWithPlace:(Location *)location completion:(void (^)(NSArray *routes, NSError *error))completion {
    completion(mockRouteWithouthPlaces1Array(), nil);
}

- (void)newRoutesWithLocation:(Location *)location completion:(void (^)(NSArray *routes, NSError *error))completion {
    completion(mockRouteWithouthPlaces2Array(), nil);
}

#pragma mark - User routes

- (void)favoriteRoutesWithUser:(User *)user completion:(void (^)(NSArray *routes, NSError *error))completion {
    completion(user.favoriteRoutes, nil);
}

- (void)userOutingsWithUser:(User *)user completion:(void (^)(NSArray *routes, NSError *error))completion {
    completion(user.outings, nil);
}

- (void)userRoutesWithUser:(User *)user completion:(void (^)(NSArray *routes, NSError *error))completion {
    completion(user.ownRoutes, nil);
}

#pragma mark - Actions

- (void)toggleRouteFavoriteWithUser:(User *)user route:(Route *)route completion:(void (^)(NSError *error))completion {
    if(route.favorite) {
        route.favorite = false;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"routeUnfavorited" object:self
                                                          userInfo:@{@"route": route}];
    } else {
        route.favorite = true;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"routeFavorited" object:self
                                                          userInfo:@{@"route": route}];
    }
    //    if ([user.favoriteRoutes containsObject:route]) {
    //        [user.favoriteRoutes removeObject:route];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"routeUnfavorited" object:self
    //                                                          userInfo:@{@"route": route, @"user": user}];
    //    } else {
    //        [user.favoriteRoutes addObject:route];
    //        route.favorite = true; // TODO: fix this
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"routeFavorited" object:self
    //                                                          userInfo:@{@"route": route, @"user": user}];
    //    }
    completion(nil);
}

- (void)finishRouteWithUser:(User *)user route:(Route *)route completion:(void (^)(NSError *))completion {
    [user.outings addObject:route];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"routeFinished" object:self
                                                      userInfo:@{@"route": route, @"user": user}];
    completion(nil);
}

- (void)rateRouteWithUser:(User *)user route:(Route *)route rating:(double)rating completion:(void (^)(NSError *error))completion {
    route.rating = rating; // naive implementation for now
    [[NSNotificationCenter defaultCenter] postNotificationName:@"routeRated" object:self
                                                      userInfo:@{@"route": route, @"user": user}];
    completion(nil);
}

@end
