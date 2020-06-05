

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}


class ValidationClass: NSObject {
    
    func isTextViewBlank(_ textview:UITextView) -> Bool {
        
        if textview.text.isEmpty || textview.text == "Address*"{
            return true
        }
        return false
    }
    
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    
    //MARK:- Method used to validate checkout form
    func validateCheckOutForm(_ obj : ViewController) -> Bool {
        obj.view.endEditing(true)
        if isBlank(obj.customerNameTxtFld) {
            Constant.showError(obj, message: "Enter name.")
            return false
        }else if isBlank(obj.emailTxtFld) {
            Constant.showError(obj, message: "Enter email.")
            return false
        }else if isBlank(obj.phoneNoTxtFld){
            Constant.showError(obj, message: "Enter phone number.")
            return false
        }else if isBlank(obj.amountTxtFld){
            Constant.showError(obj, message: "Enter amount.")
            return false
        }else if isTextViewBlank(obj.shippingAddressTxtView){
            Constant.showError(obj, message: "Enter shipping address.")
            return false
        }else if isBlank(obj.shippingStateTxtFld){
            Constant.showError(obj, message: "Enter shipping state.")
            return false
        }else if isBlank(obj.shippingCityTxtFld){
            Constant.showError(obj, message: "Enter shipping city.")
            return false
        }else if isTextViewBlank(obj.billingAddressTxtView){
            Constant.showError(obj, message: "Enter billing address.")
            return false
        }else if isBlank(obj.billingStateTxtFld){
            Constant.showError(obj, message: "Enter billing state.")
            return false
        }else if isBlank(obj.billingCityTxtFld){
            Constant.showError(obj, message: "Enter billing city.")
             return false
        }else {
            return true
        }
    }
}

