

import UIKit

class Constant: NSObject {
    
    static let MerchantEmail = "mobileteam.fullestop@gmail.com" //Mercent email id
    static let SecretKey = "RXSRbqdYlPqQAKvoIW01W5OV5yHyjKvbHn3TOhS96i0G2v4Ls4MoaBjg91PtMkFtIImxZeG5xHMzcQlEV826JmmTobmaw1EfK0MJ" //Secret key
    static let AssigneeCode = "SDK"
    static let CurrencyCode = "BHD" // Currency Code
    static let SDKLanguage = "en"   // SDk language
    static let CountryCode = "BHR"   // Country code
    static let ZipCode = "00973"   // Zipcode

    
    //MARK: - This function is used to show alert when error occur in app
  static  func showError(_ viewController: UIViewController,message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}

