package com.paytapsintegrationkotlin

import android.content.Context
import android.content.Intent
import android.os.Bundle

import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.paytapsintegrationkotlin.adpter.PaymentDetailAdapter


import com.paytapsintegrationkotlin.model.CommonModel
import com.paytapsintegrationkotlin.model.ResponseModel
import kotlinx.android.synthetic.main.activity_payment_detail.*

import java.util.ArrayList

class PaymentDetailActivity : AppCompatActivity() {

    internal var context: Context = this
    internal var arrayList = ArrayList<CommonModel>()
    internal var model: ResponseModel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_payment_detail)

        init()
    }

    private fun init() {
        getIntentData()
        setOnClickListeners()
    }

    /**
     * This method is used to set click listeners on views
     */
    private fun setOnClickListeners() {
        ivBack.setOnClickListener { v -> onBackPressed() }
    }


    /***
     * This method is used to get data from the previous activity
     */
    private fun getIntentData() {
        val `in` = intent
        model = `in`.getSerializableExtra("model") as ResponseModel
        if (model != null) {
            arrayList.add(CommonModel("Order ID:-", model!!.orderID))
            arrayList.add(CommonModel("Transaction Id:-", model!!.transactionId))
            arrayList.add(CommonModel("Token:-", model!!.token))
            arrayList.add(CommonModel("Amount:-", model!!.amount))
            arrayList.add(CommonModel("Transaction by:-", model!!.transactionTitle))
            arrayList.add(CommonModel("Email:-", model!!.email))
            arrayList.add(CommonModel("Number:-", model!!.number))

            recyclerView.setLayoutManager(
                LinearLayoutManager(
                    context,
                    LinearLayoutManager.VERTICAL,
                    false
                )
            )
            // Set the data in adapter
            recyclerView.setAdapter(PaymentDetailAdapter(context, arrayList))
        }
    }
}
