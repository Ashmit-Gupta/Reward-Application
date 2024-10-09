import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:reward_app/data/model/payment_model.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';
import 'package:reward_app/res/app_apis_keys.dart';
import 'package:reward_app/res/app_constants.dart';

import '../data/response/status.dart';

class PaymentViewModel extends ChangeNotifier {
  late Razorpay _razorpay;
  final FirebaseStorageRepo _firebaseStorageRepo;

  Resource _paymentStatus = Resource(status: Status.IDLE);
  Resource get paymentStatus => _paymentStatus;
  Reward? _rewardBeingPurchased;

  PaymentViewModel(this._firebaseStorageRepo) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void initiatePayment(PaymentModel paymentModel, Reward reward) {
    _paymentStatus = Resource.loading();
    notifyListeners();
    var options = {
      'key': ApiKeys.razorPayKey, // Replace with your Razorpay key
      'amount':
          (paymentModel.amount * 100), // Razorpay accepts paise, not rupees
      'currency': paymentModel.currency,
      'name': AppConstants.AppName,
      'description': paymentModel.description,
      'prefill': {
        'contact': '1234567890',
        'email': FirebaseAuth.instance.currentUser?.email ??
            "mainhibatarha@gmail.com",
      }
    };

    try {
      _razorpay.open(options);
      _rewardBeingPurchased = reward;
    } catch (e) {
      _paymentStatus = Resource.error("error failed to pay : $e");
      notifyListeners();
      print('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _paymentStatus = Resource.completed(response.paymentId);
    notifyListeners();
    try {
      await _firebaseStorageRepo.addData(_rewardBeingPurchased!);
      print("Payment Success: ${response.paymentId}");
    } catch (e) {
      _paymentStatus =
          Resource.error("error while add the data to firebase : $e");
      notifyListeners();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentStatus = Resource.error(
        "Error Code: ${response.code}, Message: ${response.message}");
    print("Payment Error: ${response.code} - ${response.message}");
    notifyListeners();
  }
}
