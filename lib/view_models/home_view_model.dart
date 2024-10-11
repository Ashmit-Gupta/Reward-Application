import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';

import '../data/model/user_reward_model.dart';
import '../data/response/response.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseStorageRepo _firebaseStorageRepo;

  HomeViewModel(this._firebaseStorageRepo);

//todo create user view model
  Resource<List<Reward>> _rewards = Resource(status: Status.IDLE);
  Resource<List<Reward>> get rewards => _rewards;

  Reward? _selectedReward;
  Reward? get selectedReward => _selectedReward;

  void selectReward(Reward reward) {
    _selectedReward = reward;
    // notifyListeners();
  }

  void fetchUserRewards(String userId) async {
    _rewards = Resource.loading();
    notifyListeners();
    try {
      _firebaseStorageRepo.getUserRewards(userId).listen((response) {
        _rewards = response;
        notifyListeners();
      });
    } catch (e) {
      _rewards = Resource.error("error while fetching the Rewards !! $e");
    }
  }
}
