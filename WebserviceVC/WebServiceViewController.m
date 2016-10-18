//
//  WebServiceViewController.m
//  Diet Calorie Counter
//
//  Created by User Name on 5/17/13.
//  Copyright (c) 2013 xoomsolutions. All rights reserved.
//

#import "WebServiceViewController.h"
#import "NSData+Base64.h"

static WebServiceViewController *wsVC =nil;
@interface WebServiceViewController ()

@end

@implementation WebServiceViewController
@synthesize strURL,jsonString,strCallHttpMethod,strMethodName,activeDownload,imageConnection;
@synthesize delegate,responseData,strCurrentRequestMethod;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
     // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(WebServiceViewController*) wsVC{
	
	if(!wsVC){
		wsVC = [[WebServiceViewController alloc] init];
	}
	
	return wsVC;
	
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [[NSString stringWithFormat:@"%@",key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

//- (NSMutableDictionary *)sendRequestForMethod:(NSString *)strMethod withParameter:(NSMutableDictionary *)dictDetail
//{
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[BSQ_URL stringByAppendingFormat:@"?method=%@",strMethod]]];
//    [request setHTTPMethod:@"POST"];
//    
//    NSData *body = [self encodeDictionary:dictDetail];
//    
//    [request setValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:body];
//    
//    NSError *error;
//    NSURLResponse *resultResponse;
//    // Perform request and get JSON back as a NSData object
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&resultResponse error:&error];
//    // Get JSON as a NSString from NSData response
//    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",json_string);
//    
//    NSLog(@"response=%@",json_string);
//   // NSError *jsonError = nil;
//    
//    NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[json_string JSONValue]];
//    
//    return dictResult;
//}


#pragma marks --- Uploading images ---

//- (NSMutableDictionary *)sendRequestForMethod:(NSString *)strMethod withParameter:(NSMutableDictionary *)dictDetail withImageArray:(NSMutableArray *)arrImages
//
//{
//    //NSString *strDicDescription = [dictDetail description];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
//    [request setURL:[NSURL URLWithString:[BSQ_URL stringByAppendingFormat:@"?method=%@",strMethod]]];
//    
//    //    [request addValue:@"lat=42.345573&log=-71.098326&userId=12345&phone=408-8327642" forHTTPHeaderField:@"info"];
//    
////    [request addValue:strDicDescription forHTTPHeaderField:@"info"];
//    
//          [request setHTTPMethod:@"POST"];
//    for (int i = 0; i < arrImages.count; i++) {
//        UIImage *image = [arrImages objectAtIndex:i];
//        
//        // encode the image as JPEG
//       NSString *base64EncodedImage = [UIImageJPEGRepresentation(image, 0.8) base64EncodingWithLineLength:0];
//        
//        [dictDetail setObject:base64EncodedImage forKey:[NSString stringWithFormat:@"image%d",i+1]];
//    }
//    NSData *dicData = [self encodeDictionary:dictDetail];
//
//    
//
//        // add the POST data as the request body
//    [request setValue:[NSString stringWithFormat:@"%d", dicData.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:dicData];
//    
//        
//        // now lets make the connection to the web
//        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"returnString %@", returnString);
//        
//      
//        // NSError *jsonError = nil;
//    
//    NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[returnString JSONValue]];
//    
//    return dictResult;
//}

- (NSMutableDictionary *)sendReqGoogleApiWith:(NSMutableDictionary *)dictDetail
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:strURL]];
    [request setHTTPMethod:strCallHttpMethod];
    
    NSData *body = [self encodeDictionary:dictDetail];
    
    [request setValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    
    NSError *error;
    NSURLResponse *resultResponse;
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&resultResponse error:&error];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"response=%@",json_string);
    // NSError *jsonError = nil;
    
//    NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[json_string JSONValue]];
    
    NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil]];
    
    return dictResult;
    
}

- (NSMutableDictionary *)sendRequestWithParameter:(NSMutableDictionary *)dictDetail
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:[strURL stringByAppendingFormat:@"?method=%@",strMethodName]]];
    [request setHTTPMethod:strCallHttpMethod];
    
    NSData *body = [self encodeDictionary:dictDetail];
    
    [request setValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    
    NSError *error;
    NSURLResponse *resultResponse;
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&resultResponse error:&error];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"response=%@",json_string);
    // NSError *jsonError = nil;
    
    //    NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[json_string JSONValue]];
    
    if ([json_string isEqualToString:@""])
    {
        NSLog(@"Data Not Found");
        NSMutableDictionary *dictResult = nil;
        return dictResult;
    }
    else
    {
        NSMutableDictionary *dictResult =[NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil]];
        return dictResult;
    }
    
}

//+ (NSMutableDictionary *)simpleURLFetch:(NSString * )methodName param:(NSDictionary *)jsonDict
//{
////    NSString *strURL;
////    if ([methodName isEqualToString:@"Address"]) {
////        strURL=[NSString stringWithFormat:@"%@%@",Place_URL
////                ,@"?Key=CJ99-DH15-CC53-BX99&$Top=10"];
////    }
////    
////    else
////    {
////        strURL=[NSString stringWithFormat:@"%@%@",LatLong_URL
////                ,@"?Key=CJ99-DH15-CC53-BX99"];
////    }
//    
//    
//    
//    //NSLog(@"strURL is %@",strURL);
//    
//    
//    
//    
//    for(int i=0;i<[[jsonDict allKeys]  count];i++)
//    {
//        
//        NSString *strParam=[NSString stringWithFormat:@"&%@=%@",[[jsonDict allKeys] objectAtIndex:i],[jsonDict valueForKey:[[jsonDict allKeys] objectAtIndex:i]]];
//        // NSLog(@"strparm is %@",strParam);
//        strURL= [strURL stringByAppendingFormat:@"%@",strParam];
//    }
//    
//    
//    //    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?method=login&email=%@&password=%@",BaseURL,@"kiran@gmail.com",@"abc"]]];
//    //
//    NSLog(@"strurl is %@",strURL);
//    
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//    
//    NSError *err1=nil;
//    NSData *response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err1];
//    
//    if(err1)
//    {
//        NSLog(@"err is %@",err1);
//    }
//    NSError *jsonParsingError = nil;
//    NSMutableDictionary *dictResonse = [NSJSONSerialization JSONObjectWithData:response
//                                                                       options:0 error:&jsonParsingError];
//    
//    
//    
//    return dictResonse;
//}

-(NSMutableDictionary *)PostDataWithImage:(UIImage *)profileImage withParameter:(NSMutableDictionary *)dictParameters withImageKey:(NSString *)strImageKey{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:[strURL stringByAppendingFormat:@"?method=%@",strMethodName]]];
    [request setHTTPMethod:strCallHttpMethod];
    
    NSString *base64EncodedImage = [UIImageJPEGRepresentation(profileImage, 0.8) base64EncodingWithLineLength:0];
    
    [dictParameters setObject:base64EncodedImage forKey:strImageKey];
    
    NSData *dicData = [self encodeDictionary:dictParameters];
    [request setValue:[NSString stringWithFormat:@"%d", dicData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:dicData];
    
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    NSLog(@"returnString %@", returnString);
    
    
    // NSError *jsonError = nil;
    
    NSMutableDictionary *dictResult =[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
    
    return dictResult;
    
}


#pragma mark Check Network Connection

//- (BOOL)connected
//{
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
//    return !(networkStatus == NotReachable);
//}
//
//#pragma mark - NSURLConnection Delegate
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    if ([delegate respondsToSelector:@selector(webserviceConnection:didFailWithError:)]) {
//        [delegate webserviceConnection:connection didFailWithError:error];
//    }
//}


//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [responseData appendData:data];
//}


//- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    if ([delegate respondsToSelector:@selector(webserviceConnectionDidFinishLoading:successFullyGotData:currentReqMethod:)]) {
//        [delegate webserviceConnectionDidFinishLoading:connection successFullyGotData:responseData currentReqMethod:strCurrentRequestMethod];
//    }
//}
//- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
// totalBytesWritten:(NSInteger)totalBytesWritten
//totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
//{
//    if ([delegate respondsToSelector:@selector(webserviceconnection:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
//        [delegate webserviceconnection:connection didSendBodyData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
//    }
//
//}

//-(void)PostData:(NSMutableDictionary *)dictDetail
//{
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
//    [request setURL:[NSURL URLWithString:[strURL stringByAppendingFormat:@"?method=%@",strMethodName]]];
//    [request setHTTPMethod:strCallHttpMethod];
//    
//    NSData *body = [self encodeDictionary:dictDetail];
//    
//    [request setValue:[NSString stringWithFormat:@"%d", body.length] forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:body];
//      
//    responseData = [NSMutableData data];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    [connection start];
//    
//    
//}

@end
