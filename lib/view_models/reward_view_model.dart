import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';

import '../data/model/user_reward_model.dart';
import '../data/response/response.dart';

class RewardViewModel extends ChangeNotifier {
  final FirebaseStorageRepo _firebaseStorageRepo;

  RewardViewModel(this._firebaseStorageRepo);

  Resource<List<Reward>> _rewards = Resource(status: Status.IDLE);
  Resource<List<Reward>> get rewards => _rewards;

  Future<void> fetchRewards(String userId) async {
    try {
      _rewards = Resource.loading();
      notifyListeners();
      // final response = await _firebaseStorageService.getUserRewards(userId);
      final response = await _firebaseStorageRepo.getUserRewards("userID1");
      _rewards = response;
    } catch (e) {
      _rewards = Resource.error("Failed to fetch rewards");
    } finally {
      notifyListeners();
    }
  }
}
