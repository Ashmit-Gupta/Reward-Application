import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reward_app/data/model/user_model.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';
import 'package:reward_app/view_models/user_view_model.dart';

import '../data/model/user_reward_model.dart';
import '../data/response/response.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseStorageRepo _firebaseStorageRepo;
  final UserViewModel _userViewModel;

  HomeViewModel(this._firebaseStorageRepo, this._userViewModel) {
    // print("log home view model constructor called ");
    // fetchUserRewards();
  }

  Resource<List<Reward>> _rewards = Resource(status: Status.IDLE);
  Resource<List<Reward>> get rewards => _rewards;

  Reward? _selectedReward;
  Reward? get selectedReward => _selectedReward;

  @override
  //dispose() should only be used to clean up any resources (like streams, controllers) when the ViewModel is being permanently disposed of (usually when the widget is removed from the widget tree or the app lifecycle ends). If your ViewModel doesn’t manage resources like these, you don't need to add much to dispose().
  void dispose() {
    print("dispose of hoe view model");
    clearHomeData();
    super.dispose();
  }

  void selectReward(Reward reward) {
    _selectedReward = reward;
    notifyListeners();
  }

  void fetchUserRewards() async {
    _rewards = Resource.loading();
    notifyListeners();
    UserData user = await _userViewModel.getUser();
    try {
      // _firebaseStorageRepo.getUserRewards(user.id).listen((response) {
      //   _rewards = response;
      //   notifyListeners();
      // });
      final rewardStream = _firebaseStorageRepo.getUserRewards(user.id);
      await for (final response in rewardStream) {
        _rewards = response;
        notifyListeners();
      }
    } catch (e) {
      _rewards = Resource.error("error while fetching the Rewards !! $e");
      notifyListeners();
    }
  }

  //when we log out or need to clear the home related data
  void clearHomeData() {
    _selectedReward = null;
    _rewards = Resource.completed([]);
    _rewards = Resource(status: Status.IDLE);
    notifyListeners();
  }
}
