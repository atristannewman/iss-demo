//
//  NetworkService.h
//  ISS
//
//  Created by Tristan on 29/08/22.
//

#import <UIKit/UIKit.h>


//CHECK: typedef void(^completion)(BOOL, NSDictionary * _Nullable);

@interface NetworkService : UIViewController

- (void)getlocation:(void(^_Nullable)(NSDictionary *_Nullable result , NSError *_Nullable error))callback;

@end
