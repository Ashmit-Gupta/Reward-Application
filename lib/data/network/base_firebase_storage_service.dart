import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/data/response/response.dart';

abstract class BaseFirebaseStorageService {
  Future<Resource<List<Reward>>> getUserRewards(String userId);

  Future<Resource<List<Reward>>> getAllRewards();
}
