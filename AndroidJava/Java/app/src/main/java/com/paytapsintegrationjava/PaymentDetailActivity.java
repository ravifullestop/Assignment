package com.paytapsintegrationjava;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;
import androidx.recyclerview.widget.LinearLayoutManager;

import com.paytapsintegrationjava.adpter.PaymentDetailAdapter;
import com.paytapsintegrationjava.databinding.ActivityPaymentDetailBinding;
import com.paytapsintegrationjava.model.CommonModel;
import com.paytapsintegrationjava.model.ResponseModel;

import java.util.ArrayList;

public class PaymentDetailActivity extends AppCompatActivity {

    ActivityPaymentDetailBinding view;
    Context context = this;
    ArrayList<CommonModel> arrayList = new ArrayList<>();
    ResponseModel model;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        view = DataBindingUtil.setContentView(this, R.layout.activity_payment_detail);

        init();
    }

    private void init() {
        getIntentData();
        setOnClickListeners();
    }

    /**
     * This method is used to set click listeners on views
     */
    private void setOnClickListeners() {
        view.ivBack.setOnClickListener(v -> {
            onBackPressed();
        });
    }

    /***
     * This method is used to get data from the previous activity
     */
    private void getIntentData() {
        Intent in = getIntent();
        model = (ResponseModel) in.getSerializableExtra("model");
        if (model != null) {
            arrayList.add(new CommonModel("Order ID:-", model.getOrderID()));
            arrayList.add(new CommonModel("Transaction Id:-", model.getTransactionId()));
            arrayList.add(new CommonModel("Token:-", model.getToken()));
            arrayList.add(new CommonModel("Amount:-", model.getAmount()));
            arrayList.add(new CommonModel("Transaction by:-", model.getTransactionTitle()));
            arrayList.add(new CommonModel("Email:-", model.getEmail()));
            arrayList.add(new CommonModel("Number:-", model.getNumber()));

            view.recyclerView.setLayoutManager(new LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false));
            // Set the data in adapter
            view.recyclerView.setAdapter(new PaymentDetailAdapter(context, arrayList));

        }
    }
}
