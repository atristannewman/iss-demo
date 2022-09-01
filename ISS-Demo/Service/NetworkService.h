//
//  NetworkService.h
//  ISS
//
//  Created by Tristan on 29/08/22.
//

#import <UIKit/UIKit.h>

@interface NetworkService : NSObject

- (void)getlocation:(void(^_Nullable)(NSDictionary *_Nullable result , NSError *_Nullable error))callback;

@end
