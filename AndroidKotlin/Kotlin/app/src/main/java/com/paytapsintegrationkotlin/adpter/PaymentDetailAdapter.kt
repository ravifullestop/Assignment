package com.paytapsintegrationkotlin.adpter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


import com.paytapsintegrationkotlin.R
import com.paytapsintegrationkotlin.model.CommonModel

import java.util.ArrayList

class PaymentDetailAdapter(
    internal var context: Context,
    internal var arrayList: ArrayList<CommonModel>
) : RecyclerView.Adapter<PaymentDetailAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, i: Int): ViewHolder {
        val view = LayoutInflater.from(context)
            .inflate(R.layout.inflate_payment_detail_list_item, parent, false)
        return ViewHolder(view)
    }


    override fun onBindViewHolder(viewHolder: ViewHolder, pos: Int) {
        val model = arrayList[pos]

        viewHolder.tv_title.text = model.title
        viewHolder.tv_value.text = model.value
    }


    override fun getItemCount(): Int {
        return arrayList.size
    }

    /**
     * View Holder for represent the single Row views
     */
    inner class ViewHolder(internal var layout: View) : RecyclerView.ViewHolder(layout) {
        internal var tv_title: TextView
        internal var tv_value: TextView

        init {
            tv_title = layout.findViewById(R.id.tv_title)
            tv_value = layout.findViewById(R.id.tv_value)
        }
    }

    companion object {
        private val TAG = PaymentDetailAdapter::class.java.simpleName
    }

}
