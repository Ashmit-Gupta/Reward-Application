import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/response/response.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';

import '../data/model/user_reward_model.dart';

class WalletViewModel extends ChangeNotifier {
  final FirebaseStorageRepo _firebaseStorageRepo;
  WalletViewModel(this._firebaseStorageRepo);

  Reward? _selectedReward;
  Reward? get selectedReward => _selectedReward;

  Resource<List<Reward>> _allRewards = Resource(status: Status.IDLE);
  Resource<List<Reward>> get allRewards => _allRewards;

  @override
  void dispose() {
    clearWalletData();
    super.dispose();
  }

  void fetchAllRewards() async {
    _allRewards = Resource.loading();
    notifyListeners();
    try {
      _firebaseStorageRepo.getAllRewards().listen((response) {
        _allRewards = response;
        notifyListeners();
      });
    } catch (e) {
      _allRewards = Resource.error(
          " error while getting data from the cloud , walletview model : $e");
      notifyListeners();
    }
  }

  void selectReward(Reward reward) {
    _selectedReward = reward;
    notifyListeners();
  }

  void clearSelectedReward() {
    _selectedReward = null; // Method to clear the selected reward if needed.
    notifyListeners();
  }

  void clearWalletData() {
    _selectedReward = null;
    _allRewards = Resource(status: Status.IDLE); // Reset rewards list
    notifyListeners();
  }
}
