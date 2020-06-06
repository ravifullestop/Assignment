//
//  PaymentDetailVC.h
//  DemoPaytabsObjectiveC
//
//  Created by Prahalad Kumawat on 06/06/20.
//  Copyright © 2020 Prahalad Kumawat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentDetailVC : UIViewController

@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *transactionID;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *customerName;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *token;
//@property (nonatomic, assign) NSString *tokenizedCustomerPassword;
@property (nonatomic, retain) NSString *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *phnNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *transactionbyLbl;
@property (weak, nonatomic) IBOutlet UILabel *amountlbl;
@property (weak, nonatomic) IBOutlet UILabel *tokenLbl;
@property (weak, nonatomic) IBOutlet UILabel *transactionIDbl;

@end

NS_ASSUME_NONNULL_END
