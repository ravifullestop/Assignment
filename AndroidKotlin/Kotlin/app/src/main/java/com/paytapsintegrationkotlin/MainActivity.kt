package com.paytapsintegrationkotlin

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.paytabs.paytabs_sdk.payment.ui.activities.PayTabActivity
import com.paytabs.paytabs_sdk.utils.PaymentParams
import com.paytapsintegrationkotlin.model.ResponseModel
import com.paytapsintegrationkotlin.utils.Config
import kotlinx.android.synthetic.main.activity_main.*
import java.util.*
import androidx.core.app.ComponentActivity.ExtraData
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T


class MainActivity : AppCompatActivity() {

    val context = this
    var orderId = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        init()
    }


    private fun init() {
        setOnClickListeners()
    }


    /**
     * This method is used to set click listeners on views
     */
    private fun setOnClickListeners() {
        tvCheckOut.setOnClickListener { v -> checkValidation() }
    }

    /**
     * Empty field validation check
     */
    private fun checkValidation() {
        if (edName.text.toString().isEmpty()) {
            showToast("Enter name.")
        } else if (edEmail.text.toString().isEmpty()) {
            showToast("Enter email.")
        } else if (edPhoneNumber.text.toString().isEmpty()) {
            showToast("Enter phone number.")
        } else if (edAmount.text.toString().isEmpty()) {
            showToast("Enter amount.")
        } else if (edShippingAddress.text.toString().isEmpty()) {
            showToast("Enter shipping address.")
        } else if (edState.text.toString().isEmpty()) {
            showToast("Enter shipping state.")
        } else if (edCity.text.toString().isEmpty()) {
            showToast("Enter shipping city.")
        } else if (edBillingAddress.text.toString().isEmpty()) {
            showToast("Enter billing address.")
        } else if (edBillingState.text.toString().isEmpty()) {
            showToast("Enter billing state.")
        } else if (edBillingCity.text.toString().isEmpty()) {
            showToast("Enter billing city.")
        } else {
            makePayment()
        }
    }

    private fun makePayment() {
        val i = Random().nextInt(900000) + 100000
        orderId = "" + i
        val intent = Intent(applicationContext, PayTabActivity::class.java)
        intent.putExtra(PaymentParams.MERCHANT_EMAIL, Config.MERCHANT_EMAIL)
        intent.putExtra(PaymentParams.SECRET_KEY, Config.SECRET_KEY)
        intent.putExtra(PaymentParams.LANGUAGE, Config.LANGUAGE)
        intent.putExtra(PaymentParams.TRANSACTION_TITLE, edName.text.toString())
        intent.putExtra(
            PaymentParams.AMOUNT,
            java.lang.Double.parseDouble(edAmount.text.toString())
        )
        intent.putExtra(PaymentParams.CUSTOMER_PHONE_NUMBER, edPhoneNumber.text.toString())
        intent.putExtra(PaymentParams.CUSTOMER_EMAIL, edEmail.text.toString())

        intent.putExtra(PaymentParams.CURRENCY_CODE, Config.CURRENCY_CODE)
        intent.putExtra(PaymentParams.ORDER_ID, orderId)
        intent.putExtra(PaymentParams.PRODUCT_NAME, "Item 1, Item 2")

        //Billing Address
        intent.putExtra(PaymentParams.ADDRESS_BILLING, edBillingAddress.text.toString())
        intent.putExtra(PaymentParams.COUNTRY_BILLING, Config.COUNTRY_BILLING)
        intent.putExtra(PaymentParams.CITY_BILLING, edBillingCity.text.toString())
        intent.putExtra(PaymentParams.STATE_BILLING, edBillingState.text.toString())
        intent.putExtra(PaymentParams.POSTAL_CODE_BILLING, Config.POSTAL_CODE)

        //Shipping Address
        intent.putExtra(PaymentParams.ADDRESS_SHIPPING, edShippingAddress.text.toString())
        intent.putExtra(PaymentParams.COUNTRY_SHIPPING, Config.COUNTRY_BILLING)
        intent.putExtra(PaymentParams.CITY_SHIPPING, edCity.text.toString())
        intent.putExtra(PaymentParams.STATE_SHIPPING, edState.text.toString())
        intent.putExtra(PaymentParams.POSTAL_CODE_SHIPPING, Config.POSTAL_CODE)

        //Payment Page Style
        intent.putExtra(PaymentParams.PAY_BUTTON_COLOR, "#2474bc")

        //Tokenization
        intent.putExtra(PaymentParams.IS_TOKENIZATION, true)

        //PREAUTH
        //We have enabled the Pre-Auth but since it is not enabled in merchant panel it is not allowing to do. So we have commented the code.
        //intent.putExtra(PaymentParams.IS_PREAUTH, true)

        startActivityForResult(intent, PaymentParams.PAYMENT_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK && requestCode == PaymentParams.PAYMENT_REQUEST_CODE) {
            Log.e("Tag", data!!.getStringExtra(PaymentParams.RESPONSE_CODE)!!)
            if ("100" == data.getStringExtra(PaymentParams.RESPONSE_CODE)) {
                showToast("The transaction is successful")
                Log.e("Tag", data.getStringExtra(PaymentParams.TRANSACTION_ID)!!)
                if (data.hasExtra(PaymentParams.TOKEN) && !data.getStringExtra(PaymentParams.TOKEN)!!.isEmpty()) {

                    /////Set the payment result data in an Response model
                    val model = ResponseModel()
                    model.orderID = orderId
                    model.transactionId = data.getStringExtra(PaymentParams.TRANSACTION_ID)
                    model.token = data.getStringExtra(PaymentParams.TOKEN)
                    model.email = data.getStringExtra(PaymentParams.CUSTOMER_EMAIL)
                    model.number = edPhoneNumber.text.toString()
                    model.customerPassword = data.getStringExtra(PaymentParams.CUSTOMER_PASSWORD)
                    model.transactionId = edName.text.toString()
                    model.amount = "" + edAmount.text.toString() + " BHD"

                    edName.setText("")
                    edEmail.setText("")
                    edPhoneNumber.setText("")
                    edAmount.setText("")
                    edShippingAddress.setText("")
                    edCity.setText("")
                    edState.setText("")
                    edBillingAddress.setText("")
                    edBillingState.setText("")
                    edBillingCity.setText("")

                    //// Start the activity to show the payment result
                    val intent = Intent(context, PaymentDetailActivity::class.java)
                    intent.putExtra("model", model)
                    startActivity(intent)
                }
            } else {
                Log.e("TAG", data.getStringExtra(PaymentParams.RESULT_MESSAGE));
                showToast(data.getStringExtra(PaymentParams.RESULT_MESSAGE))
            }
        }
    }

    /**
     * Show short time Toast message
     *
     * @param message
     */
    private fun showToast(message: String?) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }


}
