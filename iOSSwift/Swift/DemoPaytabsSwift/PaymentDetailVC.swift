

import UIKit

class PaymentDetailVC: BaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    /******Get payment detail from payment gatway screen*********/
    var paymentDetailDict : [String:Any] = [:]
    
    /******Initialize array for payment detail*****/
    var paymentDetailListArray = [[String:Any]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Payment Detail"
        
        /*******Set cross Button in the left pf navigation bar***********/
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissController))
        
        //Set TableView UI with Dynamic height of cell
         tableView.separatorStyle = .none
         tableView.estimatedRowHeight = 44
         tableView.rowHeight = UITableView.automaticDimension
        
         print(paymentDetailDict)
         paymentDetailListArray.append(paymentDetailDict)
    }
    
    
}


//MARK:- TableView delegate and datasource methods
extension PaymentDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentDetailListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = paymentDetailListArray[indexPath.row]
        let json = JSON(dict)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailTableCell", for: indexPath) as! PaymentDetailTableCell
        
        cell.orderIdLbl.text = json["orderId"].stringValue
        cell.phnNoLbl.text = json["phoneNumber"].stringValue
        cell.emailLbl.text = json["tokenizedCustomerEmail"].stringValue
        cell.transactionbyLbl.text = json["customer_name"].stringValue
        cell.amountlbl.text = "\(json["amount"].stringValue.currency()) "
        cell.tokenLbl.text = json["token"].stringValue
        cell.transactionIDbl.text = json["transaction_id"].stringValue
      
        return cell
    }
    
}

