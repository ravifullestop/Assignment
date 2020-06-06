//
//  PaymentDetailVC.m
//  DemoPaytabsObjectiveC
//
//  Created by Prahalad Kumawat on 06/06/20.
//  Copyright © 2020 Prahalad Kumawat. All rights reserved.
//

#import "PaymentDetailVC.h"

@interface PaymentDetailVC ()

@end

@implementation PaymentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.orderIdLbl.text        = self.orderId;
    self.transactionIDbl.text   = self.transactionID;
    self.tokenLbl.text          = self.token;
    self.phnNoLbl.text          = self.phoneNumber;
    self.emailLbl.text          = self.email;
    self.transactionbyLbl.text  = self.customerName;
    self.amountlbl.text         = self.amount;
    
}

@end
