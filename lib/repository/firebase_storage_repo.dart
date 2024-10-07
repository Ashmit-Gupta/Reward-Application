import 'package:reward_app/data/network/firebase_storage_services.dart';

import '../data/model/user_reward_model.dart';
import '../data/response/response.dart';

class FirebaseStorageRepo {
  final FirebaseStorageServices _firebaseStorageServices;
  FirebaseStorageRepo(this._firebaseStorageServices);

  Future<Resource<List<Reward>>> getUserRewards(String userId) async {
    return await _firebaseStorageServices.getUserRewards(userId);
  }

  Future<Resource<List<Reward>>> getAllRewards() async {
    return await _firebaseStorageServices.getAllRewards();
  }
}
