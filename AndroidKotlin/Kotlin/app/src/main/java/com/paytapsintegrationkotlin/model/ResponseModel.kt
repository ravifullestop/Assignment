package com.paytapsintegrationkotlin.model

import java.io.Serializable

class ResponseModel : Serializable {
    var orderID: String = ""
    var transactionTitle: String = ""
    var amount: String = ""
    var email: String = ""
    var number: String = ""
    var transactionId: String = ""
    var token: String = ""
    var customerPassword: String = ""
}
