import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/payment_view_model.dart';
import 'package:reward_app/data/model/payment_model.dart';

import '../data/response/status.dart';

class PaymentPage extends StatelessWidget {
  final PaymentModel paymentModel;
  final Reward reward;
  const PaymentPage(
      {super.key, required this.paymentModel, required this.reward});

  @override
  Widget build(BuildContext context) {
    PaymentViewModel paymentViewModel = Provider.of<PaymentViewModel>(context);

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
            _buildRulesAndConditions(),

            SizedBox(height: 20),

            // Buy Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Trigger payment initiation
                  paymentViewModel.initiatePayment(paymentModel, reward);
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

  Widget _buildRulesAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• You receive 10 points with your first purchase.',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '• Points expire after 11 months.',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '• For each \$5 spent, you receive 250 points.',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '• Each purchase earns a minimum of 10 points and a maximum of 10,000 points.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
