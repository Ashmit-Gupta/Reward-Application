import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/data/network/base_firebase_storage_service.dart';
import 'package:reward_app/data/response/response.dart';

class FirebaseStorageServices extends BaseFirebaseStorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Resource<List<Reward>>> getUserRewards(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('rewards')
          .get();

      final rewards = snapshot.docs
          .map((doc) => Reward.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return Resource.completed(rewards);
    } catch (e) {
      print("error from firestore cloud $e");
      return Resource.error("Failed to load rewards: $e");
    }
  }

  @override
  Future<Resource<List<Reward>>> getAllRewards() async {
    try {
      final snapshot = await _firestore.collection('rewards').get();

      final allRewards = snapshot.docs.map((doc) {
        print(
            'Reward data: ${doc.data()}'); // Debug: Print the raw Firestore data
        return Reward.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return Resource.completed(allRewards);
    } catch (e) {
      print("error while getting all rewards : $e");
      return Resource.error("error !! $e");
    }
  }
}
