import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/data/response/response.dart';

abstract class BaseFirebaseStorageService {
  Stream<Resource<List<Reward>>> getUserRewards(String userId);
  Stream<Resource<List<Reward>>> getAllRewards();
}
