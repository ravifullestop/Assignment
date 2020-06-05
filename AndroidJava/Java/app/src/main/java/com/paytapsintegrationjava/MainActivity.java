package com.paytapsintegrationjava;

import androidx.appcompat.app.AppCompatActivity;
import androidx.databinding.DataBindingUtil;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.paytabs.paytabs_sdk.payment.ui.activities.PayTabActivity;
import com.paytabs.paytabs_sdk.utils.PaymentParams;


import com.paytapsintegrationjava.databinding.ActivityMainBinding;
import com.paytapsintegrationjava.model.ResponseModel;
import com.paytapsintegrationjava.utils.Config;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    String TAG = MainActivity.class.getSimpleName();
    ActivityMainBinding view;
    Context context = this;
    String orderId = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        view = DataBindingUtil.setContentView(this, R.layout.activity_main);

        init();
    }

    private void init() {
        setOnClickListeners();
    }


    /**
     * This method is used to set click listeners on views
     */
    private void setOnClickListeners() {
        view.tvCheckOut.setOnClickListener(v -> {
            checkValidation();
        });
    }

    /**
     * Empty field validation check
     */
    private void checkValidation() {
        if (view.edName.getText().toString().isEmpty()) {
            showToast("Enter name.");
        } else if (view.edEmail.getText().toString().isEmpty()) {
            showToast("Enter email.");
        } else if (view.edPhoneNumber.getText().toString().isEmpty()) {
            showToast("Enter phone number.");
        } else if (view.edAmount.getText().toString().isEmpty()) {
            showToast("Enter amount.");
        } else if (view.edShippingAddress.getText().toString().isEmpty()) {
            showToast("Enter shipping address.");
        } else if (view.edState.getText().toString().isEmpty()) {
            showToast("Enter shipping state.");
        } else if (view.edCity.getText().toString().isEmpty()) {
            showToast("Enter shipping city.");
        } else if (view.edBillingAddress.getText().toString().isEmpty()) {
            showToast("Enter billing address.");
        } else if (view.edBillingState.getText().toString().isEmpty()) {
            showToast("Enter billing state.");
        } else if (view.edBillingCity.getText().toString().isEmpty()) {
            showToast("Enter billing city.");
        } else {
            makePayment();
        }
    }

    private void makePayment() {
        int i = new Random().nextInt(900000) + 100000;
        orderId = "" + i;
        Intent in = new Intent(getApplicationContext(), PayTabActivity.class);
        in.putExtra(PaymentParams.MERCHANT_EMAIL, Config.MERCHANT_EMAIL);
        in.putExtra(PaymentParams.SECRET_KEY, Config.SECRET_KEY);
        in.putExtra(PaymentParams.LANGUAGE, Config.LANGUAGE);
        in.putExtra(PaymentParams.TRANSACTION_TITLE, view.edName.getText().toString());
        in.putExtra(PaymentParams.AMOUNT, Double.parseDouble(view.edAmount.getText().toString()));
        in.putExtra(PaymentParams.CUSTOMER_PHONE_NUMBER, view.edPhoneNumber.getText().toString());
        in.putExtra(PaymentParams.CUSTOMER_EMAIL, view.edEmail.getText().toString());

        in.putExtra(PaymentParams.CURRENCY_CODE, Config.CURRENCY_CODE);
        in.putExtra(PaymentParams.ORDER_ID, orderId);
        in.putExtra(PaymentParams.PRODUCT_NAME, "Item 1, Item 2");

        //Billing Address
        in.putExtra(PaymentParams.ADDRESS_BILLING, view.edBillingAddress.getText().toString());
        in.putExtra(PaymentParams.COUNTRY_BILLING, Config.COUNTRY_BILLING);
        in.putExtra(PaymentParams.CITY_BILLING, view.edBillingCity.getText().toString());
        in.putExtra(PaymentParams.STATE_BILLING, view.edBillingState.getText().toString());
        in.putExtra(PaymentParams.POSTAL_CODE_BILLING, Config.POSTAL_CODE);

        //Shipping Address
        in.putExtra(PaymentParams.ADDRESS_SHIPPING, view.edShippingAddress.getText().toString());
        in.putExtra(PaymentParams.COUNTRY_SHIPPING, Config.COUNTRY_BILLING);
        in.putExtra(PaymentParams.CITY_SHIPPING, view.edCity.getText().toString());
        in.putExtra(PaymentParams.STATE_SHIPPING, view.edState.getText().toString());
        in.putExtra(PaymentParams.POSTAL_CODE_SHIPPING, Config.POSTAL_CODE);

        //Payment Page Style
        in.putExtra(PaymentParams.PAY_BUTTON_COLOR, "#2474bc");

        //Tokenization
        in.putExtra(PaymentParams.IS_TOKENIZATION, true);

        //IS_PREAUTH
        //We have enabled the Pre-Auth but since it is not enabled in merchant panel it is not allowing to do. So we have commented the code.
        //in.putExtra(PaymentParams.IS_PREAUTH, true);

        startActivityForResult(in, PaymentParams.PAYMENT_REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK && requestCode == PaymentParams.PAYMENT_REQUEST_CODE) {
            Log.e("Tag", data.getStringExtra(PaymentParams.RESPONSE_CODE));
            if ("100".equals(data.getStringExtra(PaymentParams.RESPONSE_CODE))) {
                showToast("The transaction is successful");
                Log.e("Tag", data.getStringExtra(PaymentParams.TRANSACTION_ID));
                if (data.hasExtra(PaymentParams.TOKEN) && !data.getStringExtra(PaymentParams.TOKEN).isEmpty()) {

                    /////Set the payment result data in an Response model
                    ResponseModel model = new ResponseModel();
                    model.setOrderID(orderId);
                    model.setTransactionId(data.getStringExtra(PaymentParams.TRANSACTION_ID));
                    model.setToken(data.getStringExtra(PaymentParams.TOKEN));
                    model.setEmail(data.getStringExtra(PaymentParams.CUSTOMER_EMAIL));
                    model.setNumber(view.edPhoneNumber.getText().toString());
                    model.setCustomerPassword(data.getStringExtra(PaymentParams.CUSTOMER_PASSWORD));
                    model.setTransactionTitle(view.edName.getText().toString());
                    model.setAmount("" + view.edAmount.getText().toString() + " BHD");

                    view.edName.setText("");
                    view.edEmail.setText("");
                    view.edPhoneNumber.setText("");
                    view.edAmount.setText("");
                    view.edShippingAddress.setText("");
                    view.edCity.setText("");
                    view.edState.setText("");
                    view.edBillingAddress.setText("");
                    view.edBillingState.setText("");
                    view.edBillingCity.setText("");

                    //// Start the activity to show the payment result
                    Intent intent = new Intent(context, PaymentDetailActivity.class);
                    intent.putExtra("model", model);
                    startActivity(intent);
                }
            } else {
                showToast(data.getStringExtra(PaymentParams.RESULT_MESSAGE));
            }
        }
    }

    /**
     * Show short time Toast message
     *
     * @param message
     */
    private void showToast(String message) {
        Toast.makeText(MainActivity.this, message, Toast.LENGTH_SHORT).show();
    }


}
