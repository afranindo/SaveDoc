//
//  ViewController.m
//  SaveDoc
//
//  Created by Febrian Doni on 9/22/14.
//  Copyright (c) 2014 suitmedia. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface ViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSMutableString *someText = [NSMutableString stringWithString:@"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"  \"http://www.w3.org/TR/html4/loose.dtd\"><html xmlns:v=\"urn:schemas-microsoft-com:vml\"xmlns:o=\"urn:schemas-microsoft-com:office:office\"xmlns:w=\"urn:schemas-microsoft-com:office:word\"xmlns=\"http://www.w3.org/TR/REC-html40\"><h2>Spectacular Mountains</h2>"];
  NSString *fileURLString = [[[NSBundle mainBundle] URLForResource:@"pic_mountain" withExtension:@"jpg"] absoluteString];
  [someText appendFormat:@"<img src=\"%@\" alt=\"Mountain View\" style=\"width:304px;height:228px\"/></html>", fileURLString];
  NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.doc"];
  
  NSError *error = nil;
  BOOL succeeded = [someText writeToFile:destinationPath
                              atomically:YES
                                encoding:NSUTF8StringEncoding
                                   error:&error];
  
  if (succeeded) {
    NSLog(@"Successfully stored the file at: %@",destinationPath);
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    [mailController setMailComposeDelegate:self];
    [mailController setSubject:@"Doc File"];
    NSString *textForEmail = @"";
    [mailController setMessageBody:textForEmail isHTML:YES];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:destinationPath];
    if (data.length) {
      [mailController addAttachmentData:data mimeType:@"file/doc" fileName:@"MyFile.doc"];
    }
    [self presentViewController:mailController animated:YES completion:^{
      
    }];
  } else {
    NSLog(@"Failed to store the file. Error = %@", error);
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
