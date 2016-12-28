//
//  ViewController.m
//  TwitterApp
//
//  Created by Wadee Sami on 12/26/16.
//  Copyright © 2016 Wadee AbuZant. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textViewRef;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self styleUIElments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlertMessage: (NSString *) message {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Title" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
        [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];


}
- (IBAction)shareBtnClicked:(id)sender {
    if ([self.textViewRef isFirstResponder]) {
        //the keyboard in active
        [self.textViewRef resignFirstResponder];
    }
    
    //show the alert
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Title" message:@"Tweet Your Note" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction * tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController * twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            //message has to be < 140 char
            if ([self.textViewRef.text length] < 140) {
                [twitterVC setInitialText:self.textViewRef.text];
            }else{
                [twitterVC setInitialText: [self.textViewRef.text substringToIndex:140]];
            }
            
            //show the ios-related view for the user
            [self presentViewController:twitterVC animated:YES completion:nil];
            
        }else{
            //objection, show an alert message to inform the user to sign in to twitter
            [self showAlertMessage:@"Please Sign into Twitter"];
        }
    }];

    UIAlertAction * facebookAction = [UIAlertAction actionWithTitle:@"Post To Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController * facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [facebookVC setInitialText:self.textViewRef.text];
            
            //show the ios-related view for the user
            [self presentViewController:facebookVC animated:YES completion:nil];
            
        }else{
            //objection, show an alert message to inform the user to sign in to twitter
            [self showAlertMessage:@"Please Sign into Facebook"];
        }
    }];
    

    [alertController addAction:tweetAction];
    [alertController addAction:facebookAction];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    }

- (void) styleUIElments {
    self.textViewRef.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    
//    self.textViewRef.backgroundColor = [UIColor colorWithRed:1.0 green:0.1 blue:0.3 alpha:1.0];
}

@end
