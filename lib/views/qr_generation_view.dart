import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/res/components/custom_app_bar.dart';
import 'package:reward_app/res/components/custom_drawer.dart';
import 'package:reward_app/res/components/reward_card.dart';
import 'package:reward_app/res/components/reward_list_builder.dart';
import 'package:reward_app/view_models/home_view_model.dart';

import '../data/model/user_reward_model.dart';
import '../utils/utils.dart';

class QrGenerationView extends StatefulWidget {
  const QrGenerationView({super.key});

  @override
  State<QrGenerationView> createState() => _QrGenerationViewState();
}

class _QrGenerationViewState extends State<QrGenerationView> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    final currReward = homeViewModel.selectedReward;
    if (currReward == null) {
      return Center(
        child: Text("Please select a Reward!!"),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: Column(
        children: [
          RewardCard(
              reward: currReward,
              checkWalletCard: false,
              cardFun: () {
                print("in the qr code !!");
              })
        ],
      ),
    );
  }
}

//todo agar user ne same name ka coupon liya h toh ussme add ho jayegi value
//todo redem pe subtract
