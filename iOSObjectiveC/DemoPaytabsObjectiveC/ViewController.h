//
//  ViewController.h
//  DemoPaytabsObjectiveC
//
//  Created by Prahalad Kumawat on 06/06/20.
//  Copyright © 2020 Prahalad Kumawat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ViewController : UIViewController

/**
*CheckOut screen Outlets
*/

@property (weak, nonatomic) IBOutlet UITextField *customerNameTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *amountTxtFld;

//**Shipping address Outlet
@property (weak, nonatomic) IBOutlet UITextField *shippingStateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *shippingCityTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *shippingcountryTxtFld;
@property (weak, nonatomic) IBOutlet IQTextView *shippingAddressTxtView;

//**Billing address Outlet
@property (weak, nonatomic) IBOutlet IQTextView *billingAddressTxtView;
@property (weak, nonatomic) IBOutlet UITextField *billingStateTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *billingCityTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *billingcountryTxtFld;

- (IBAction)checkOutBtnAction:(UIButton *)sender;

@end

