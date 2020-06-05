

import UIKit

class PaymentDetailTableCell: UITableViewCell {
    
    
    //outlet
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var phnNoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var transactionbyLbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var tokenLbl: UILabel!
    @IBOutlet weak var transactionIDbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
