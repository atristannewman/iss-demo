//
//  NetworkService.m
//  ISS
//
//  Created by Tristan on 29/08/22.
//

#import <Foundation/Foundation.h>
#import "NetworkService.h"
#import "Constant.h"

@interface NetworkService ()

@end

@implementation NetworkService


- (void)getlocation:(void(^)(NSDictionary *result, NSError *error))callback {
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:issNowURL]];
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if(httpResponse.statusCode == 200)
      {
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          if (parseError == nil) {
              callback(responseDictionary,nil);
          }
          else {
              callback(nil,parseError);
          }
      }
      else
      {
          NSLog(@"Error: %@", error);
          callback(nil,error);
      }
    }];
    [dataTask resume];
}

@end
