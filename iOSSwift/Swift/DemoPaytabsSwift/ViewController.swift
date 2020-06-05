

import UIKit
import IQKeyboardManager

class ViewController: BaseViewController {
    
    /**
     *CheckOut screen Outlets
     */
    @IBOutlet weak var customerNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var phoneNoTxtFld: UITextField!
    @IBOutlet weak var amountTxtFld: UITextField!
    @IBOutlet weak var currencyCodeTxtFld: UITextField!
    
    //**Shipping address Outlet
    @IBOutlet weak var shippingStateTxtFld: UITextField!
    @IBOutlet weak var shippingCityTxtFld: UITextField!
    @IBOutlet weak var shippingcountryTxtFld: UITextField!
    @IBOutlet weak var shippingAddressTxtView: IQTextView!
    
    //**Billing address Outlet
    
    @IBOutlet weak var billingAddressTxtView: IQTextView!
    @IBOutlet weak var billingStateTxtFld: UITextField!
    @IBOutlet weak var billingCityTxtFld: UITextField!
    @IBOutlet weak var billingcountryTxtFld: UITextField!

    
    
    var paytabsPayementGatewayVC: PTFWInitialSetupViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Checkout"
        
        //**Set right Arrow on Text Field****//
        shippingcountryTxtFld.applyDownArrow()
        billingcountryTxtFld.applyDownArrow()
        
        
        //**Set right Arrow on txt field****//
        shippingAddressTxtView.layer.cornerRadius = 5
        shippingAddressTxtView.layer.masksToBounds = true
        shippingAddressTxtView.layer.borderColor = UIColor.lightGray.cgColor
        shippingAddressTxtView.layer.borderWidth = 0.5
        
        billingAddressTxtView.layer.cornerRadius = 5
        billingAddressTxtView.layer.masksToBounds = true
        billingAddressTxtView.layer.borderColor = UIColor.lightGray.cgColor
        billingAddressTxtView.layer.borderWidth = 0.5
    }
    
      //MARK:- CheckOut Button Action
    /** This function is used to redirest user to paytabs payment gatway screen where user fill their card detail
       * and successfully done their trasaction
        **/
 
    @IBAction func checkOutBtnAction(_ sender: UIButton) {
        
 
        let order_id = String(Date().timeIntervalSince1970)

        
        
        
        if ValidationClass().validateCheckOutForm(self) { // check blank validation on checkout form
            
            let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
            self.paytabsPayementGatewayVC = PTFWInitialSetupViewController.init(
                bundle: bundle,
                andWithViewFrame: self.view.frame,
                andWithAmount: Float(amountTxtFld.text!)!,
                andWithCustomerTitle: customerNameTxtFld.text!,
                andWithCurrencyCode: Constant.CurrencyCode,
                andWithTaxAmount: 0.0,
                andWithSDKLanguage: Constant.SDKLanguage,
                andWithShippingAddress: shippingAddressTxtView.text!,
                andWithShippingCity: shippingCityTxtFld.text!,
                andWithShippingCountry: Constant.CountryCode,
                andWithShippingState: shippingStateTxtFld.text!,
                andWithShippingZIPCode: Constant.ZipCode,
                andWithBillingAddress: billingAddressTxtView.text!,
                andWithBillingCity: billingCityTxtFld.text!,
                andWithBillingCountry: Constant.CountryCode,
                andWithBillingState: billingStateTxtFld.text!,
                andWithBillingZIPCode: Constant.ZipCode,
                andWithOrderID: order_id,
                andWithPhoneNumber: phoneNoTxtFld.text!,
                andWithCustomerEmail: emailTxtFld.text!,
                andIsTokenization: true,
                andIsPreAuth: false,
                andWithMerchantEmail: Constant.MerchantEmail,
                andWithMerchantSecretKey: Constant.SecretKey,
                andWithAssigneeCode: Constant.AssigneeCode ,
                andWithThemeColor:UIColor.purpleColor,
                andIsThemeColorLight: false)
            

            /********* andIsPreAuth: false*********
             ******We have enabled the Pre-Auth but since it is not enabled in merchant panel it is not allowing to do. So we have commented the code.
              ********/
            
            
            
            /****
             ***** This is called when user press backf button on payment screen
             */
            self.paytabsPayementGatewayVC.didReceiveBackButtonCallback = {
            }
            
            
            /****
             * This is called when user press checkout  button on checkout screen
             */
            self.paytabsPayementGatewayVC.didStartPreparePaymentPage = {
                
            }
            
            /****
            * This is called when user moved on payment screen
            */
            self.paytabsPayementGatewayVC.didFinishPreparePaymentPage = {
                
            }
            
            
            /****
            * This is called when user complete their trasaction
              In this we can get payment deatil  or transaction detail done by user
            */
            self.paytabsPayementGatewayVC.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
                print("Response Code: \(responseCode)")
                print("Response Result: \(result)")
                
                /*** responseCode == 100  (The transaction is successful.)
                  ** Checked whether the trascation is succesfull or not
                 */
                if responseCode == 100 { // rThe transaction is successful.
                    var dict : [String:Any] = [:]
                    dict["transaction_id"] = transactionID
                    dict["tokenizedCustomerEmail"] = tokenizedCustomerEmail
                    dict["token"] = token
                    dict["customer_name"] = self.customerNameTxtFld.text!
                    dict["amount"] = self.amountTxtFld.text!
                    dict["tokenizedCustomerPassword"] = tokenizedCustomerPassword
                    dict["orderId"] = order_id
                    dict["phoneNumber"] = self.phoneNoTxtFld.text!
                    
                    
                    /*** When  Transaction is successfull blank all the field oncheckout screen**/
                    self.customerNameTxtFld.text = ""
                    self.emailTxtFld.text = ""
                    self.phoneNoTxtFld.text = ""
                    self.amountTxtFld.text = ""
                    self.shippingAddressTxtView.text = ""
                    self.shippingStateTxtFld.text = ""
                    self.shippingCityTxtFld.text = ""
                    self.shippingcountryTxtFld.text = ""
                    self.billingAddressTxtView.text = ""
                    self.billingStateTxtFld.text = ""
                    self.billingCityTxtFld.text = ""
                    self.billingcountryTxtFld.text = ""
                    
                    /*******************************/
 
                
                    /********Redirect user on payment detail screnn after sussccesfully payment done**********/
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
                    vc.paymentDetailDict = dict
                    self.presentViewController(vc)
                    
                    
                } else { //*********There is some error occur in trasaction
                    Constant.showError(self, message: "\(result)")
                }
                
                
                
            }
            
            /*** Add payment gatway screen on current screen
             */
            self.view.addSubview(paytabsPayementGatewayVC.view)
            self.addChild(paytabsPayementGatewayVC)
            
            paytabsPayementGatewayVC.didMove(toParent: self)
        }
    }
}




