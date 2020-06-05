

import Foundation


extension UIViewController {
    
    //MARK: - This function is used to show another screen
    func presentViewController(_ PresentController: UIViewController){
        let DetailVC = PresentController
        let navctrl = UINavigationController(rootViewController: DetailVC)
        navctrl.modalPresentationStyle = .fullScreen
        self.present(navctrl, animated: true, completion: nil)
    }
    
    //MARK: - This function is used to hide current screen
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension UITextField {

    //MARK: - Set TextField right image
    func applyDownArrow(){
        let dropdownButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        dropdownButton.backgroundColor = .clear
        dropdownButton.setImage(UIImage(named: "down-arrow-grey"), for: UIControl.State())
        let container = UIView(frame: dropdownButton.frame)
        container.backgroundColor = .clear
        container.addSubview(dropdownButton)
        self.rightView = container
        self.rightViewMode = .always
    }
    
}


  //MARK:- App Color Codes
extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var purpleColor: UIColor{
        return UIColor(named: "purpleColor")!
    }
    
}


extension String {
    func currency() -> String {
        return "\(self) \(Constant.CurrencyCode)"
       }
}
