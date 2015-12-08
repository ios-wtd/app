//
//  Route.m
//  RouteToDo
//
//  Created by Gabriel Gayan on 15/19/11.
//  Copyright © 2015 RouteToDo. All rights reserved.
//

#import "Route.h"

@implementation Route

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _location = dictionary[@"location"];
        _imageUrl = [NSURL URLWithString:dictionary[@"image_url"]];
        _author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        _fullDescription = dictionary[@"full_description"];
        if (!(dictionary[@"rating"] == (id)[NSNull null])) {
            _rating = [dictionary[@"rating"] doubleValue];
        }
        _places = [Place placesWithArray:dictionary[@"places"]];
    }
    return self;
}

+ (NSArray *)routeWithArray:(NSArray *) array {
    NSMutableArray *routeCategories = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [routeCategories addObject:[[Route alloc] initWithDictionary:dictionary]];
    }
    return routeCategories;
}

+ (Route *)emptyRoute {
    Route *route = [[Route alloc] init];
    route.places = @[
                     [[Place alloc] init],
                     [[Place alloc] init],
                     [[Place alloc] init]
                     ];

    return route;
}


@end
