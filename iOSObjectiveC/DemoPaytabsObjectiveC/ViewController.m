//
//  ViewController.m
//  DemoPaytabsObjectiveC
//
//  Created by Prahalad Kumawat on 06/06/20.
//  Copyright © 2020 Prahalad Kumawat. All rights reserved.
//

#import "ViewController.h"
#import "HelperClasses/MyConstant.h"
#import <paytabs-iOS/paytabs_iOS.h>
#import "PaymentDetailVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//MARK:- CheckOut Button Action
/*
 * This function is used to redirest user to paytabs payment gatway screen where user fill their card detail
 * and successfully done their trasaction
 */

- (IBAction)checkOutBtnAction:(UIButton *)sender {
    
    NSString *message = @"";
    
    /*
     Basic validation for non empty fields only rest errors are already coming from SDKs response.
     
    */

    if ([self.customerNameTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for name";
    } else if ([self.emailTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for email";
    } else if ([self.phoneNoTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for phone number";
    } else if ([self.amountTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for amount";
    } else if ([self.shippingAddressTxtView.text  isEqual: @""]) {
        message = @"Please enter a value for shipping address";
    } else if ([self.shippingStateTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for shipping state";
    } else if ([self.shippingCityTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for shipping city";
    } else if ([self.billingAddressTxtView.text  isEqual: @""]) {
        message = @"Please enter a value for billing address";
    } else if ([self.billingStateTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for billing state";
    } else if ([self.billingCityTxtFld.text  isEqual: @""]) {
        message = @"Please enter a value for billing city";
    }
    
    /*
     Showing the error message based on validation error
     */
    if (![message isEqual: @""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                   message: message
                                   preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {}];

        [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *orderId = [[NSString alloc] initWithFormat:@"%d", arc4random_uniform(900000) + 100000];
    //float amount = [self.amountTxtFld.text floatValue];
    NSString *inputString = self.amountTxtFld.text;
    float value = [inputString floatValue];

    
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"bundle"]];
    
    
    PTFWInitialSetupViewController *view = [[PTFWInitialSetupViewController alloc]
                                            initWithBundle:bundle
                                            andWithViewFrame:self.view.frame
                                            andWithAmount: value
                                            andWithCustomerTitle:_customerNameTxtFld.text
                                            andWithCurrencyCode:CurrencyCode
                                            andWithTaxAmount:0
                                            andWithSDKLanguage:SDKLanguage
                                            andWithShippingAddress:self.shippingAddressTxtView.text
                                            andWithShippingCity:self.shippingCityTxtFld.text
                                            andWithShippingCountry:ShippingCountry
                                            andWithShippingState:self.shippingStateTxtFld.text
                                            andWithShippingZIPCode:ShippingZIPCode
                                            andWithBillingAddress:self.billingAddressTxtView.text
                                            andWithBillingCity: self.billingCityTxtFld.text
                                            andWithBillingCountry:BillingCountry
                                            andWithBillingState: self.billingStateTxtFld.text
                                            andWithBillingZIPCode:BillingZIPCode
                                            andWithOrderID: orderId
                                            andWithPhoneNumber:self.phoneNoTxtFld.text
                                            andWithCustomerEmail:self.emailTxtFld.text
                                            andIsTokenization:YES
                                            andIsPreAuth:NO
                                            andWithMerchantEmail: merchantEmail//@"mobileteam.fullestop@gmail.com"
                                            andWithMerchantSecretKey:SecretKey
                                            andWithAssigneeCode:AssigneeCode
                                            andWithThemeColor:[UIColor redColor]
                                            andIsThemeColorLight:YES];


    
    /*
    *  This is called when user press back button on payment screen
    */
    view.didReceiveBackButtonCallback = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    /*
    * This is called when user press checkout  button on checkout screen
    */
    view.didStartPreparePaymentPage = ^{
        // Start Prepare Payment Page
        // Show loading indicator
    };
    
    /*
    * This is called when user moved on payment screen
    */
    view.didFinishPreparePaymentPage = ^{
        // Finish Prepare Payment Page
        // Stop loading indicator
    };
    
    view.didReceiveFinishTransactionCallback = ^(int responseCode, NSString * _Nonnull result, int transactionID, NSString * _Nonnull tokenizedCustomerEmail, NSString * _Nonnull tokenizedCustomerPassword, NSString * _Nonnull token, BOOL transactionState) {
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:true completion:^{
            
            NSLog(@"Response Code: %i", responseCode);
            NSLog(@"Response Result: %@", result);
            
            // In Case you are using tokenization
            NSLog(@"Tokenization Cutomer Email: %@", tokenizedCustomerEmail);
            NSLog(@"Tokenization Customer Password: %@", tokenizedCustomerPassword);
            NSLog(@"TOkenization Token: %@", token);
            
            if (responseCode == 100) {
                
                NSString *tID = [[NSString alloc] initWithFormat:@"%d", transactionID];
                NSString *tokenString = [[NSString alloc] initWithFormat:@"%@", token];
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                PaymentDetailVC *vc = [sb instantiateViewControllerWithIdentifier: @"PaymentDetailVC"];
              
                vc.orderId                  = orderId;
                vc.transactionID            = tID;
                vc.token                    = tokenString;
                vc.email                    = self.emailTxtFld.text;
                vc.customerName             = self.customerNameTxtFld.text;
                vc.amount                   = self.amountTxtFld.text;
                vc.phoneNumber              = self.phoneNoTxtFld.text;
                
                [self presentViewController:vc animated:YES completion:nil];

                
            } else {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                           message: result
                                           preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {}];

                [alert addAction:dismissAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    };
    
    [self presentViewController:view animated:true completion:nil];
}
@end
