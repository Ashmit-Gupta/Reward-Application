import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/data/network/base_firebase_storage_service.dart';
import 'package:reward_app/data/response/response.dart';

class FirebaseStorageServices extends BaseFirebaseStorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<Resource<List<Reward>>> getUserRewards(String userId) {
    // try {
    //   final snapshot = await _firestore
    //       .collection('users')
    //       .doc(userId)
    //       .collection('rewards')
    //       .get();
    //
    //   final rewards = snapshot.docs
    //       .map((doc) => Reward.fromMap(doc.data() as Map<String, dynamic>))
    //       .toList();
    //
    //   return Resource.completed(rewards);
    // } catch (e) {
    //   print("error from firestore cloud $e");
    //   return Resource.error("Failed to load rewards: $e");
    // }

    try {
      return _firestore
          .collection('users')
          .doc(userId)
          .collection('rewards')
          .snapshots()
          .map((snapshot) {
        final rewards = snapshot.docs.map((doc) {
          return Reward.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        return Resource.completed(rewards);
      });
    } catch (e) {
      print("Error fetching user Rewards from storage service: $e");
      return Stream.value(Resource.error("Failed to load rewards : $e"));
    }
  }

  @override
  Stream<Resource<List<Reward>>> getAllRewards() {
    // try {
    //   final snapshot = await _firestore.collection('rewards').get();
    //
    //   final allRewards = snapshot.docs.map((doc) {
    //     print(
    //         'Reward data: ${doc.data()}'); // Debug: Print the raw Firestore data
    //     return Reward.fromMap(doc.data() as Map<String, dynamic>);
    //   }).toList();
    //   return Resource.completed(allRewards);
    // } catch (e) {
    //   print("error while getting all rewards : $e");
    //   return Resource.error("error !! $e");
    // }

    try {
      return _firestore.collection('rewards').snapshots().map((snapshot) {
        final allRewards = snapshot.docs.map((doc) {
          return Reward.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        return Resource.completed(allRewards);
      });
    } catch (e) {
      print("Error fetching all rewards stream: $e");
      return Stream.value(Resource.error("error !! $e"));
    }
  }

  @override
  Future<Resource<void>> addCard(Reward reward) async {
    try {
      // Prepare the reward data to be stored
      Map<String, dynamic> rewardData = reward.toJson();

      // Check if the user is signed in
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return Resource.error("User is not authenticated");
      }

      // Create a reference to the user document ,
      DocumentReference userDoc = _firestore.collection('users').doc(userId);

      DocumentSnapshot userSnapShot = await userDoc.get();

      if (!userSnapShot.exists) {
        await userDoc.set({'userId': userId});
        print('User document created for userID: $userId');
      }
      // Set the reward data under the user's document
      await userDoc
          .collection('rewards')
          .doc(reward.title)
          .set(rewardData, SetOptions(merge: true));

      return Resource.completed(null);
    } catch (e) {
      print("Error adding reward to Firestore: $e");
      return Resource.error("Failed to add reward: $e");
    }
  }
}
