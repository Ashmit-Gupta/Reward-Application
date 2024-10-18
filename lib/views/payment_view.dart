import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/view_models/payment_view_model.dart';
import 'package:reward_app/data/model/payment_model.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';

import '../data/response/status.dart';
import 'components/rules_conditions.dart';

class PaymentPage extends StatelessWidget {
  // final PaymentModel paymentModel;
  // final Reward reward;
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentViewModel paymentViewModel = Provider.of<PaymentViewModel>(context);
    WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context);
    final selectedReward = walletViewModel.selectedReward;
    if (selectedReward == null) {
      return Center(child: Text('No reward selected'));
    }
    PaymentModel payment = PaymentModel(
        amount: selectedReward.points,
        currency: 'INR',
        description: selectedReward.title);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Details Section
            Text(
              'Card Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Cardholder Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Expiry Date (MM/YY)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Rules and Conditions Section
            Text(
              'Rules and Conditions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildRulesAndConditions(),

            SizedBox(height: 20),

            // Buy Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Trigger payment initiation
                  paymentViewModel.rewardBeingPurchased = selectedReward;
                  paymentViewModel.initiatePayment(payment);
                },
                child: Text("Buy Now"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),

            // Loading Indicator
            if (paymentViewModel.paymentStatus.status == Status.LOADING)
              Center(child: CircularProgressIndicator()),
            if (paymentViewModel.paymentStatus.status == Status.COMPLETED)
              Center(
                child: Text(
                  'Payment Successful!',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            if (paymentViewModel.paymentStatus.status == Status.ERROR)
              Center(
                child: Text(
                  'Error: ${paymentViewModel.paymentStatus.message}',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
