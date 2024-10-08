import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';

import '../data/model/user_reward_model.dart';

class WalletViewModel extends ChangeNotifier {
  final FirebaseStorageRepo _firebaseStorageRepo;
  WalletViewModel(this._firebaseStorageRepo);

  Resource<List<Reward>> _allRewards = Resource(status: Status.IDLE);
  Resource<List<Reward>> get allRewards => _allRewards;

  // Future<void> fetchAllRewards() async {
  //   try {
  //     _allRewards = Resource.loading();
  //     notifyListeners();
  //
  //     final response = await _firebaseStorageRepo.getAllRewards();
  //     _allRewards = response;
  //     print("the data from wallet vm is : ${_allRewards.data?[0].description}");
  //   } catch (e) {
  //     _allRewards = Resource.error("Failed to fetch rewards");
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  void fetchAllRewards() {
    _firebaseStorageRepo.getAllRewards().listen((response) {
      _allRewards = response;
      notifyListeners();
    });
  }
}
